//
//  NetworkError.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-21.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case noResponse
    case serverError
    case unknown
}

extension NetworkError {
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data for the request"
        case .noResponse:
            return "No response from the server"
        case .serverError:
            return "A server error occurred"
        case .unknown:
            return "Unknown error"
        }
    }
}
