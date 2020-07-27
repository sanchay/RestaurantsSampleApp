//
//  AutocompleteFetcher.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-23.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import Foundation
import CoreLocation

typealias AutoCompleteTermsResult = (Result<AutoCompleteTermsModel, Error>) -> Void

class AutocompleteFetcher: JSONDecodable {
    
    private var session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func fetch(name: String, location: LocationValue, _ completion: AutoCompleteTermsResult?) {
        let endPoint = RestaurantAPI.autocomplete(name, location)
        print(endPoint.path)
        session.loadData(from: endPoint) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    guard let decodedData = self.decode(type: AutoCompleteTermsModel.self, from: data) else {
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
