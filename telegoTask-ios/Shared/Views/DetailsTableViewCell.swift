//
//  DetailsTableViewCell.swift
//  telegoTask-ios
//
//  Created by Shimun on 12/24/19.
//  Copyright © 2019 Shimun. All rights reserved.
//

import UIKit
import SDWebImage

class DetailsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    //    MARK: - Lifecycle Methods
       
       override func awakeFromNib() {
           super.awakeFromNib()
           adjustSubviews()
       }
       
       //    MARK: - Private Methods
       
       func adjustSubviews() {
           self.thumbnailImageView.layer.masksToBounds = true
           self.thumbnailImageView.layer.cornerRadius = 10
       }
    
    // MARK: - Public methods
    
    func populateData(news: News) {
        self.title.text = news.title ?? ""
        self.descriptionLabel.text = news.description ?? ""
        
        guard news.thumbnail ?? "" != "", let thumbnailURL = URL(string: news.thumbnail ?? "") else {
            return
        }
        self.thumbnailImageView.sd_setImage(with: thumbnailURL, placeholderImage: UIImage(named: "thumbnailPlaceholder")!)
    }
}
