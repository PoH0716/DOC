//
//  VideoGuideTableViewCell.swift
//  DOC
//
//  Created by Po Hsiang Huang on 5/21/19.
//  Copyright © 2019 Po Hsiang Huang. All rights reserved.
//

import UIKit

class VideoGuideTableViewCell: UITableViewCell {

    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
