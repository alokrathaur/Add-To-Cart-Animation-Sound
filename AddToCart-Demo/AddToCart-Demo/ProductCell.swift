//
//  ProductTableViewCell.swift
//  AddToCart-Demo
//
//  Created by Alok Rathaur on 01/03/23.
//

import UIKit

class ProductCell: UITableViewCell {
    @IBOutlet weak var imageViewProduct: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
