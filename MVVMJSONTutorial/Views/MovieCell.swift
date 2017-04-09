//
//  MovieCell.swift
//  MVVMJSONTutorial
//
//  Created by Bao Nguyen on 4/9/17.
//  Copyright © 2017 Bao Nguyen. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell, Cellable {
    
    @IBOutlet weak private var movieImage: UIImageView!
    @IBOutlet weak private var movieTitleLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func cellIdentifier() -> String {
        return "movieCell"
    }

}
