//
//  DetailViewPresenter.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-25.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import UIKit

typealias ImageCompletion = (UIImage?) -> Void
typealias DetailResult = (Result<Business?, Error>) -> Void
typealias ReviewResult = (Result<ReviewModel, Error>) -> Void

enum ReviewError: Error {
    case empty
}

class DetailViewPresenter: NSObject {
    
    private var businessId: String!
    var completion: DetailResult?
    var business: Business?
    
    init(businessId: String) {
        self.businessId = businessId
    }
    
    func fetchImage(_ imageUrlString: String, _ completion: ImageCompletion?) {
        ImageDownloader.download(urlString: imageUrlString) { (result) in
            switch result {
            case .success(let image):
                completion?(image)
            case .failure(let error):
                print(error)
                completion?(nil)
            }
        }
    }
    
    func fetchBusinessDetails(_ completion: DetailResult?) {
        RestaurantDetailFetcher().fetchDetail(restaurantId: businessId) { (result) in
            switch result {
            case .success(let business):
                self.business = business
                completion?(.success(business))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
    func fetchReviews(_ completion: ReviewResult?) {
        RestaurantDetailFetcher().fetchReviews(restaurantId: businessId) { (result) in
            switch result {
            case .success(let result):
                guard let review = result.reviews.max (by: { $0.time_created > $1.time_created }) else {
                    completion?(.failure(ReviewError.empty))
                    return
                }
                completion?(.success(review))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
    func isSaved(_ businessId: String) -> Bool {
        return CoreDataHelper.isRestaurantSaved(id: businessId)
    }
    
    func save() {
        CoreDataHelper.save()
    }
    
    func delete(_ id: String) {
        CoreDataHelper.deleteRestaurant(id: id)
        guard let business = business else { return }
        CoreDataHelper.addRestaurant(object: business)
    }
    
    func deleteUnsavedData() {
        CoreDataHelper.reset()
    }
}
