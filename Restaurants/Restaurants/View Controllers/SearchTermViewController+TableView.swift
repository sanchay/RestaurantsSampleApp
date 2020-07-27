//
//  SearchViewController+TableView.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-22.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import UIKit

extension SearchTermViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if !isNetworkReachable {
            showNetworkError()
            return
        }
        
        let location: LocationValue = locationEngine?.isLocationEnabled ?? false ? .coord(locationEngine?.coordinates) : .name(locationField.text ?? "")
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            let searchTerm = autoCompleteTerms[selectedIndexPath.row]
            navigateToSearch(term: searchTerm, location: location)
        }
    }
}

extension SearchTermViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoCompleteTerms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableView.Cell.identifier.rawValue, for: indexPath)
        cell.textLabel?.text = autoCompleteTerms[indexPath.row]
        return cell
    }
}
