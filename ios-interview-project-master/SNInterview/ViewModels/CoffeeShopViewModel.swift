//
//  CoffeeShopViewModel.swift
//  SNInterview
//
//  Created by Dileep on 8/22/21.
//  Copyright © 2021 ServiceNow. All rights reserved.
//

import Foundation

protocol CoffeeShopReview {
    var coffeeShopReviews: [CoffeeShop]? { get }
}

public class CoffeeShopViewModel: CoffeeShopReview {
    var coffeeShopReviews: [CoffeeShop]?
    private let networkManager = NetworkManager.shared
    
    /*
     Sending a real Url for remote server experience
    */
    public func getCoffeeShopReviews(completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = SNConstants.Strings.url
        networkManager.getResponse(for: url) { [weak self] (result) in
            switch result {
            case .success(let coffeeShopReviews):
                self?.coffeeShopReviews = coffeeShopReviews
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
