//
//  NetworkManager.swift
//  SNInterview
//
//  Created by Dileep on 8/22/21.
//  Copyright © 2021 ServiceNow. All rights reserved.
//

import Foundation

public enum Result<T, Error> {
    case success(T)
    case failure(Error)
}

internal enum CoffeeShopError: Error {
    case incorrectUrl
    case incorrectResponse
    case noResponse
    case decodeError
}

/*
    Connecting to a remote service using real url so that response is fetched and after checking for error scenarios, reviews json is used to send back the response assuming as success response.
*/
public class NetworkManager {
    public static let shared = NetworkManager()
    
    func getResponse(for urlString: String, completion: @escaping (Result<[CoffeeShop], CoffeeShopError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(CoffeeShopError.incorrectUrl))
            return
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, httpResponse, error) in
            guard let _ = data, let httpUrlResponse = httpResponse as? HTTPURLResponse, error == nil else {
                completion(.failure(.noResponse))
                return
            }
            guard 200 ..< 300 ~= httpUrlResponse.statusCode else {
                completion(.failure(.incorrectResponse))
                return
            }
            guard let reviews = self?.loadFromJson(filename: SNConstants.Strings.coffeeShops) else {
                completion(.failure(.decodeError))
                return
            }
            completion(.success(reviews))
        }.resume()
    }
    
    private func loadFromJson(filename fileName: String) -> [CoffeeShop]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: SNConstants.Strings.json) {
            do {
                let data = try Data(contentsOf: url)
                let jsonData = try JSONDecoder().decode([CoffeeShop].self, from: data)
                return jsonData
            } catch {
                fatalError(SNConstants.ErrorStrings.decodeJsonError)
            }
        }
        return nil
    }
}
