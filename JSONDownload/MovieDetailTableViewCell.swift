//
//  MovieDetailTableViewCell.swift
//  JSONDownload
//
//  Created by debbb on 2020/12/23.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImageLabel: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
