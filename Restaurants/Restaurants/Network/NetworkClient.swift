//
//  NetworkClient.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-21.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import Foundation

class NetworkClient {
    
    private var session: NetworkSession
    
    init(_ session: NetworkSession) {
        self.session = session
    }
    
    func load(endPoint: EndPoint, completion: NetworkCompletion?) {
        session.loadData(from: endPoint, completion: completion)
    }
}
