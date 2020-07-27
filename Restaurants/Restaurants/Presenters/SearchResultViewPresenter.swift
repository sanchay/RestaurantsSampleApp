//
//  SearchResultViewPresenter.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-23.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import Foundation

typealias RestaurantSearchResult = (Result<RestaurantsModel, Error>) -> Void
typealias SortCompletion = ([RestaurantModel], Bool) -> Void

class SearchResultViewPresenter: NSObject {
    
    private var searchTerm: String!
    private var location: LocationValue!
    var completion: RestaurantSearchResult?
    private var isAscendingOrder: Bool = true
    
    init(searchTerm: String, location: LocationValue) {
        self.searchTerm = searchTerm
        self.location = location
    }
    
    func search() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            RestaurantsFetcher().fetch(name: self.searchTerm, location: self.location) { result in
                switch result {
                case .success(let restaurants):
                    self.completion?(.success(restaurants))
                case .failure(let error):
                    self.completion?(.failure(error))
                }
            }
        }
    }
    
    func sort(restaurants: [RestaurantModel], completion: SortCompletion?) {
        var retVal: [RestaurantModel] = []
        if isAscendingOrder {
            retVal = restaurants.sorted(by: {
                ($0.name ?? "") > ($1.name ?? "")
            })
        } else {
            retVal = restaurants.sorted(by: {
                ($0.name ?? "") < ($1.name ?? "")
            })
        }
        isAscendingOrder = !isAscendingOrder
        completion?(retVal, isAscendingOrder)
    }
}
