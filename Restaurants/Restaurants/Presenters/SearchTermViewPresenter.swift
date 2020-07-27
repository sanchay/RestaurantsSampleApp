//
//  SearchViewPresenter.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-22.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import Foundation

typealias AutoCompleteResult = (Result<[String], Error>) -> Void

struct SearchState {
    let searchTerm: String
    let location: LocationValue
}

class SearchTermViewPresenter: NSObject {
    
    weak var locationEngine: LocationProtocol?
    var workItem: DispatchWorkItem?
    var lastNameSearched: String?
    
    var completion: AutoCompleteResult?
    
    init(locationEngine: LocationProtocol?) {
        self.locationEngine = locationEngine
    }
    
    func isInputValid(searchTerm: String?, location: String?) -> Bool {
        if locationEngine?.isLocationEnabled ?? false {
            return (searchTerm?.isEmpty ?? true)
        }
        return (searchTerm?.isEmpty ?? true) && (location?.isEmpty ?? true)
    }
    
    func fetchAutoCompleteTerms(_ name: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(search(name:)), object: lastNameSearched)
        self.perform(#selector(search(name:)), with: name, afterDelay: 0.2)
        lastNameSearched = name
    }
    
    @objc private func search(name: String) {
        guard !name.isEmpty else { return }
        let location: LocationValue = (locationEngine?.isLocationEnabled ?? false) ? .coord(self.locationEngine?.coordinates) : .name("")
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            AutocompleteFetcher().fetch(name: name, location: location) { result in
                switch result {
                case .success(let termsModel):
                    let terms = termsModel.terms.map { $0.text}
                    self.completion?(.success(terms))
                case .failure(let error):
                    self.completion?(.failure(error))
                }
            }
        }
    }
}
