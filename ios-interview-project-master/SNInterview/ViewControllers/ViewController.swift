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

class ViewController: UIViewController, LoadingView {
    
    @IBOutlet private weak var reviewsTableView: UITableView!
    
    var coffeeShopViewModel = CoffeeShopViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        getReviews()
    }
    
    /*
        Get Reviews from ViewModel and Network Manager
    */
    
    private func getReviews() {
        showLoadingView()
        coffeeShopViewModel.getCoffeeShopReviews { [weak self] (result) in
            /*
             Upading UI on Main thread after response is fetched
             */
            DispatchQueue.main.async {
                self?.hideLoadingView()
                self?.reviewsTableView.reloadData()
            }
        }
    }
    
    /*
     Using Automatic Dimension for auto resizing of cells based on content
     */
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
        return coffeeShopViewModel.coffeeShopReviews?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CoffeeShopItemCell.self), for: indexPath) as? CoffeeShopItemCell, let review = coffeeShopViewModel.coffeeShopReviews?[indexPath.row] {
            cell.configure(coffeeShopReview: review)
            return cell
        }
        return UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let review = coffeeShopViewModel.coffeeShopReviews?[indexPath.row] {
            let popUpVC = PopUpViewController(review: review)
            self.present(popUpVC, animated: false, completion: nil)
        }
    }
}
