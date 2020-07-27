//
//  SearchResultViewController.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-23.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    internal var searchTerm: String!
    internal var location: LocationValue!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private lazy var presenter = SearchResultViewPresenter(searchTerm: self.searchTerm, location: self.location)
    
    var restaurants: [RestaurantModel]?
    
    internal var numberOfItemsInRow = 2
    internal var minimumSpacing: CGFloat = 5
    internal var edgeInsetPadding = 10
    
    internal var sortBarButtonItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

extension SearchResultViewController {
    
    internal func configure() {
        configurePresenter()
        presenter.search()
        activityIndicator.startAnimating()

        collectionView.backgroundColor = .clear
        
        if let layout = collectionView.collectionViewLayout as? CustomLayout {
            layout.delegate = self
        }
        
        title = Constants.NavigationTitle.searchResults.rawValue
        
        sortBarButtonItem = UIBarButtonItem(title: Constants.Sort.desc.rawValue, style: .plain, target: self, action: #selector(sortRestaurants(_:)))
        navigationItem.rightBarButtonItem = sortBarButtonItem
    }
    
    internal func configurePresenter() {
        presenter.completion = { [weak self] results in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            switch results {
            case .success(let restaurants):
                self.restaurants = restaurants.businesses.sorted(by: {
                    ($0.name ?? "") < ($1.name ?? "")
                })
                if self.restaurants?.isEmpty ?? false {
                    self.showEmptyAlert()
                    return
                }
                self.collectionView.reloadData()
            case .failure(let error):
                self.showErrorAlert(error)
            }
        }
    }
    
    internal func showEmptyAlert() {
        showAlert(title: "No restaurants found", message: "Tap ok to navigate back") { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension SearchResultViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? DetailViewController
        guard let selectedIndexRow = collectionView.indexPathsForSelectedItems?.first else {
            fatalError("Invalid selected index")
        }
        let restaurant = restaurants?[selectedIndexRow.row]
        destination?.businessId = restaurant?.id
        destination?.businessName = restaurant?.name
        destination?.businessAddress = restaurant?.location.address
        destination?.imageUrl = restaurant?.image_url
    }
    
    @objc
    func sortRestaurants(_ sender: Any) {
        guard let restaurants = restaurants else { return }
        presenter.sort(restaurants: restaurants) { [weak self] sortedRestaurants, isAscending in
            guard let self = self else { return }
            let title = !isAscending ? Constants.Sort.asc.rawValue : Constants.Sort.desc.rawValue
            self.sortBarButtonItem.title = title
            self.restaurants = sortedRestaurants
            self.collectionView.reloadData()
        }
    }
}
