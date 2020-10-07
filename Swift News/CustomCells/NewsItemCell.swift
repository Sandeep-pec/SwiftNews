//
//  NewsItemCell.swift
//  Swift News
//
//  Created by Sandeep Sangwan on 2020-10-05.
//

import UIKit

class NewsItemCell: UITableViewCell {
    
    //MARK:- Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thmbImageView: UIImageView!
    @IBOutlet weak var cellHeightConstraint: NSLayoutConstraint!
    
    var newsItem: NewsArticle? {
        didSet {
            configureCell()
        }
    }
    
    //MARK:- UI Configuration
    func configureCell() {
        titleLabel.text = newsItem?.title
        if let thmbnailHeight = newsItem?.thumbnail_height, let thmbnailWidth = newsItem?.thumbnail_width, thmbnailHeight > 0, thmbnailWidth > 0 {
            let imageViewHeight: CGFloat = ((CGFloat(thmbnailHeight)/CGFloat(thmbnailWidth))*(UIScreen.main.bounds.width))
            cellHeightConstraint.constant = imageViewHeight
        } else {
            cellHeightConstraint.constant = 0
        }
        self.layoutIfNeeded()
        if let thumbnail = newsItem?.thumbnail {
            if let image = CacheManager.shared.getImage(urlString: thumbnail) {
                thmbImageView.image = image
            } else {
                //download
                guard let url = URL(string: thumbnail) else {
                    thmbImageView.image = nil
                    return
                }
                DispatchQueue.global().async { [weak self] in
                    let thmbStr = self?.newsItem?.thumbnail ?? ""
                    if let data = try? Data(contentsOf: url) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                if thmbStr == (self?.newsItem?.thumbnail ?? "") && !thmbStr.isEmpty {
                                    self?.thmbImageView.image = image
                                    CacheManager.shared.setImage(urlString: thmbStr, image: image)
                                    self?.layoutIfNeeded()
                                }
                            }
                        }
                    }
                }
            }
            
        } else {
            thmbImageView.image = nil
        }
    }
    
    override func prepareForReuse() {
        thmbImageView.image = nil
    }
}
