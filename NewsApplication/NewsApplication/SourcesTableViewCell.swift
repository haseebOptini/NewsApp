//
//  SourcesTableViewCell.swift
//  NewsApplication
//
//  Created by Abdul Haseeb on 4/4/17.
//  Copyright © 2017 Abdul Haseeb. All rights reserved.
//

import UIKit

class SourcesTableViewCell: UITableViewCell {

    @IBOutlet weak var sourceLogoImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
