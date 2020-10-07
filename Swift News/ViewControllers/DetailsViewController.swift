//
//  DetailsViewController.swift
//  Swift News
//
//  Created by Sandeep Sangwan on 2020-10-03.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //MARK:- Properties
    @IBOutlet weak var thmbnailImageView: UIImageView!
    @IBOutlet weak var newsBodyLabel: UILabel!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    var newsArticle: NewsArticle?
    
    //MARK:- ViewController lifecycle
    override func viewDidLoad() {
        self.title = newsArticle?.title ?? "News in detail"
        self.newsBodyLabel.text = newsArticle?.selfText
        
        if let thmbnailHeight = newsArticle?.thumbnail_height, let thmbnailWidth = newsArticle?.thumbnail_width, thmbnailHeight > 0, thmbnailWidth > 0 {
            let imageViewHeight: CGFloat = ((CGFloat(thmbnailHeight)/CGFloat(thmbnailWidth))*(UIScreen.main.bounds.width))
            imageViewHeightConstraint.constant = imageViewHeight
        } else {
            imageViewHeightConstraint.constant = 0
        }
        
        if let thumbnail = newsArticle?.thumbnail {
            if let image = CacheManager.shared.getImage(urlString: thumbnail) {
                thmbnailImageView.image = image
            } else {
                //download
                guard let url = URL(string: thumbnail) else {
                    thmbnailImageView.image = nil
                    return
                }
                DispatchQueue.global().async { [weak self] in
                    if let data = try? Data(contentsOf: url) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self?.thmbnailImageView.image = image
                                CacheManager.shared.setImage(urlString: thumbnail, image: image)
                            }
                        }
                    }
                }
            }
        }
    }
}
