//
//  RestaurantsFetcher.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-23.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import Foundation

typealias RestaurantsResult = (Result<RestaurantsModel, Error>) -> Void

class RestaurantsFetcher: JSONDecodable {
    
    private var session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func fetch(name: String, location: LocationValue, _ completion: RestaurantsResult?) {
        let endPoint = RestaurantAPI.searchWithTermAndLocation(name, location)
        print(endPoint.path)
        session.loadData(from: endPoint) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    guard let decodedData = self.decode(type: RestaurantsModel.self, from: data) else {
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
