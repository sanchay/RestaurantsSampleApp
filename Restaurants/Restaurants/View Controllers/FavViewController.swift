//
//  FavViewController.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-25.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import UIKit

class FavViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var businesses: [Business]?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let businesses = FavViewPresenter.fetchFavorites() {
                self.businesses = businesses
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? DetailViewController
        guard let selectedIndexRow = tableView.indexPathForSelectedRow else {
            fatalError("Invalid selected index")
        }
        let restaurant = businesses?[selectedIndexRow.row]
        destination?.businessId = restaurant?.id
        destination?.businessName = restaurant?.name
        destination?.businessAddress = restaurant?.location?.address
        destination?.imageUrl = restaurant?.image_url
    }
}

extension FavViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.Segue.showDetails.rawValue, sender: self)
    }
}

extension FavViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableView.Cell.favorite.rawValue, for: indexPath)
        cell.textLabel?.text = businesses?[indexPath.row].name ?? ""
        return cell
    }
}
