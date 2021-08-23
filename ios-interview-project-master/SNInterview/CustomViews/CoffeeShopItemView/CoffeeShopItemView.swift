//
//  CoffeeShopItemView.swift
//  SNInterview
//
//  Copyright © 2019 ServiceNow. All rights reserved.
//

import UIKit

class CoffeeShopItemView: UIView {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    func configure(review: CoffeeShop) {
        nameLabel.text = review.name
        reviewLabel.text = review.review
        ratingLabel.text = SNConstants.Strings.rating + "\(review.rating)"
    }
}
