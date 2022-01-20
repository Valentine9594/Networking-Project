//
//  ProductTableViewCell.swift
//  NetworkAssignment
//
//  Created by neosoft on 29/12/21.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productProducer: UILabel!
    @IBOutlet weak var productCost: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        productImage.layer.borderWidth = 1
//        productImage.layer.borderColor = UIColor.red.cgColor
        productImage.contentMode = .scaleToFill
        
//        productName.textColor = .black
        productProducer.textColor = .darkGray
        productCost.textColor = .red
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        productImage.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
