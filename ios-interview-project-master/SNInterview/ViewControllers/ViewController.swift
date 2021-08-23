//
//  ViewController.swift
//  SNInterview
//
//  Copyright © 2019 ServiceNow. All rights reserved.
//

import UIKit

struct CoffeeShop: Decodable {
    let name: String
    let review: String
    let rating: Int
}

class ViewController: UIViewController {
    
    @IBOutlet private weak var reviewsTableView: UITableView!
    
    private let reviews = [
        CoffeeShop(name:"Lofty", review: "Knowledgeable staff, stacked menu. Trust the Ethiopian in a pour over if you know your flavors. Will be back for the rest of this menu soon.", rating: 4),
        CoffeeShop(name:"Zumbar", review: "Came to SD for school tour and heading back to the Bay Area after today's final meeting. Was drinking Starbucks the whole trip until my sis recommended this cafe to me. LOVE IT!", rating: 5),
        CoffeeShop(name:"Blue Bottle", review: "The place was empty the afternoon I came in, so I was able to quickly place an order for their version of a New Orleans cold brew. I received my drink right as my credit card order went through.", rating: 3),
        CoffeeShop(name:"Bird Rock", review: "When it comes to environment and ambience, this place is amazing! It has a cute lil look, yet looks a bit modern. It's very eye appealing and I would definitely deem Instagramable.", rating: 3),
        CoffeeShop(name:"Better Buzz Coffee", review: "This coffee shop is really cute. The decor is beautiful, food and coffee is tasty and the service is friendly and quick.", rating: 5)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    private func setUpTableView() {
        reviewsTableView.dataSource = self
        reviewsTableView.delegate = self
        reviewsTableView.separatorStyle = .none
        reviewsTableView.registerCell(a: CoffeeShopItemCell.self)
        reviewsTableView.rowHeight = UITableView.automaticDimension
        reviewsTableView.estimatedRowHeight = 170
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CoffeeShopItemCell.self), for: indexPath) as? CoffeeShopItemCell {
            let review = reviews[indexPath.row]
            cell.configure(coffeeShopReview: review)
            return cell
        }
        return UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {
    
}
