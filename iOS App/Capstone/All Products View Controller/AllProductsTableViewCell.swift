//
//  AllProductsTableViewCell.swift
//  Capstone
//
//  Created by Jeton Ajeti on 4/17/19.
//  Copyright © 2019 Gotham Appsters. All rights reserved.
//

import UIKit

class AllProductsTableViewCell: UITableViewCell {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var Description: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
