//
//  CoffeeShopItemCell.swift
//  SNInterview
//
//  Created by Dileep on 8/21/21.
//  Copyright © 2021 ServiceNow. All rights reserved.
//

import UIKit

class CoffeeShopItemCell: UITableViewCell {
    var coffeeShopView: CoffeeShopItemView?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(coffeeShopReview: CoffeeShop) {
        nameLabel.text = coffeeShopReview.name
        reviewLabel.text = coffeeShopReview.review
        ratingLabel.text = SNConstants.Strings.rating + "\(coffeeShopReview.rating)"
    }
    
}
