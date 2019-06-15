//
//  NewsFeedTableViewCell.swift
//  DOC
//
//  Created by Po Hsiang Huang on 5/19/19.
//  Copyright © 2019 Po Hsiang Huang. All rights reserved.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 3
        }
    }
    var url: String!
    var item: RSSItem! {
        didSet{
            titleLabel.text = item.title
            descriptionLabel.text = item.description
            url = item.link
        }
    }
}
