//
//  NewsItemCell.swift
//  Swift News
//
//  Created by Sandeep Sangwan on 2020-10-05.
//

import UIKit

class NewsItemCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thmbImageView: UIImageView!
    var newsItem: NewsArticle? {
        didSet {
            configureCell()
        }
    }
    
    func configureCell() {
        titleLabel.text = newsItem?.title
        
        if let thumbnail = newsItem?.thumbnail {
            
        } else {
            thmbImageView.image = nil
        }
    }
}
