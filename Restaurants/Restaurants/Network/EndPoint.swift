//
//  EndPoint.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-21.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import Foundation
import CoreLocation

fileprivate let limit = 20

protocol EndPoint {
    var path: String { get }
    var request: URLRequest? { get }
}

enum Location<Coordinates, LocationName> {
    case coord(Coordinates)
    case name(LocationName)
}

typealias LocationValue = Location<CLLocationCoordinate2D?, String>

enum RestaurantAPI {
    case autocomplete(String, LocationValue)
    case searchWithTermAndLocation(String, LocationValue)
    case details(String)
    case reviews(String)
}

extension RestaurantAPI: EndPoint {
    
    var path: String {
        switch self {
        case .autocomplete(let text, let location):
            let escapedString = String(describing: text.escapedString)
            switch location {
            case .coord(let coordinate):
                guard let coordinate = coordinate else { fatalError("Invalid Location Coordinates") }
                return "https://api.yelp.com/v3/autocomplete?text=\(escapedString)&latitude=\(coordinate.latitude)&longitude=\(coordinate.longitude)"
            case .name:
                return "https://api.yelp.com/v3/autocomplete?text=\(escapedString)"
            }
        case .searchWithTermAndLocation(let term, let location):
            let escapedTerm = String(describing: term.escapedString)
            switch location {
            case .coord(let coordinate):
                guard let coordinate = coordinate else { fatalError("Invalid Location Coordinates") }
                return "https://api.yelp.com/v3/businesses/search?term=\(escapedTerm)&latitude=\(coordinate.latitude)&longitude=\(coordinate.longitude)&categories=food&limit=\(limit)"
            case .name(let name):
                let escapedName = String(describing: name.escapedString)
                return "https://api.yelp.com/v3/businesses/search?term=\(escapedTerm)&location=\(escapedName)&categories=food&limit=\(limit)"
            }
        case .details(let businessId):
            return "https://api.yelp.com/v3/businesses/\(businessId)"
        case .reviews(let businessId):
            return "https://api.yelp.com/v3/businesses/\(businessId)/reviews"
        }
    }
    
    var request: URLRequest? {
        guard let url = URL(string: path) else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Bearer EKkDzj7fluwnurgVrw3mYOONcin2Jmo71sazgrfvhBkLc41wof54Tn7edvnG2fN-r24w-l-lxr0OSWNzVzSsd-bgNeJ3v98LXNIBzElLagfMZJ5y1CTG86wGThsXX3Yx", forHTTPHeaderField: "Authorization")
        return urlRequest
    }
}
