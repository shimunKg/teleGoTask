//
//  NewsTableViewCell.swift
//  telegoTask-ios
//
//  Created by Shimun on 12/23/19.
//  Copyright © 2019 Shimun. All rights reserved.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    
    // MARK: - Properties

    var starButtonAction: ((Bool) -> Void)?
    
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
    
    // MARK: - Actions

    @IBAction func starButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        starButtonAction?(sender.isSelected)
    }
    
    // MARK: - Public methods

    func populateData(with news: News) {
        self.titleLabel.text = news.title ?? ""
        self.descriptionLabel.text = news.description ?? ""
        self.dateLabel.text = (news.publishedDate ?? "").toFormat("MM/dd/yyyy hh:mm a")
        
        guard news.thumbnail ?? "" != "", let thumbnailURL = URL(string: news.thumbnail ?? "") else {
            return
        }
        self.thumbnailImageView.sd_setImage(with: thumbnailURL, placeholderImage: UIImage(named: "thumbnailPlaceholder")!)
    }
}
