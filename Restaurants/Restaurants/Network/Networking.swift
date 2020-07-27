//
//  Networking.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-21.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import Foundation

typealias NetworkCompletion = (Result<Data?, Error>) -> Void

protocol NetworkSession {
    func loadData(from endPoint: EndPoint, completion: NetworkCompletion?)
}

extension URLSession: NetworkSession {
    
    func loadData(from endPoint: EndPoint, completion: NetworkCompletion?) {
        guard let urlRequest = endPoint.request else {
            completion?(.failure(NetworkError.invalidURL))
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                guard let data = data else {
                    if let error = error {
                        completion?(.failure(error))
                    } else {
                        completion?(.failure(NetworkError.unknown))
                    }
                    return
                }
                
                completion?(.success(data))
            }
            
            dataTask.resume()
        }
    }
}
