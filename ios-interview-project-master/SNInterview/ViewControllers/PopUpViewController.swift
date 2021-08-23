//
//  PopUpViewController.swift
//  SNInterview
//
//  Created by Dileep on 8/22/21.
//  Copyright © 2021 ServiceNow. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    var coffeeShopItemView: CoffeeShopItemView?
    
    init(review: CoffeeShop) {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
        
        coffeeShopItemView = CoffeeShopItemView.fromNib() as? CoffeeShopItemView
        coffeeShopItemView?.configure(review: review)
        coffeeShopItemView?.center = view.center
        view.addSubview(coffeeShopItemView ?? UIView(frame: .zero))
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTap()
    }
    
    @objc func hideReview() {
        self.dismiss(animated: false) {
            self.view.backgroundColor = UIColor.white
        }
    }
    
    func addTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideReview))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

}
