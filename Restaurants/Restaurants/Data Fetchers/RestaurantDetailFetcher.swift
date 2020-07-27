//
//  RestaurantDetailFetcher.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-25.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import Foundation

typealias RestaurantDetailResult = (Result<Business, Error>) -> Void
typealias RestaurantReviewsResult = (Result<ReviewsModel, Error>) -> Void

class RestaurantDetailFetcher: JSONDecodable {
    
    private var session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchDetail(restaurantId: String, _ completion: RestaurantDetailResult?) {
        let endPoint = RestaurantAPI.details(restaurantId)
        print(endPoint.path)
        session.loadData(from: endPoint) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    guard let decodedData = self.decode(type: Business.self, from: data) else {
                        completion?(.failure(JSONError.invalid))
                        return
                    }
                    completion?(.success(decodedData))
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
    func fetchReviews(restaurantId: String, _ completion: RestaurantReviewsResult?) {
        let endPoint = RestaurantAPI.reviews(restaurantId)
        print(endPoint.path)
        session.loadData(from: endPoint) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    guard let decodedData = self.decode(type: ReviewsModel.self, from: data) else {
                        completion?(.failure(JSONError.invalid))
                        return
                    }
                    completion?(.success(decodedData))
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}
