//
//  ViewController.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-21.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import UIKit

class SearchTermViewController: UIViewController, NetworkReachable {
    
    @IBOutlet var stackViewCentreYConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    var autoCompleteTerms: [String] = []
    
    var locationEngine: LocationProtocol?
    
    private lazy var presenter = SearchTermViewPresenter(locationEngine: self.locationEngine)
    
    internal var searchTerm: String?
    internal var location: LocationValue?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
        configure()
    }
}

extension SearchTermViewController {
    
    internal func configure() {
        title = Constants.NavigationTitle.search.rawValue
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.hidesBackButton = true
        searchField.placeholder = Constants.Text.searchPlaceholder.rawValue
        locationField.placeholder = Constants.Text.locationPlaceholder.rawValue
        
        if !isNetworkReachable {
            showNetworkError()
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.activityIndicator.startAnimating()
            if self.locationEngine == nil {
                self.locationEngine = LocationEngine(completion: { _ in
                    print("Coordinates available now")
                    self.activityIndicator.stopAnimating()
                    self.locationField.isHidden = self.locationEngine?.isLocationEnabled ?? false
                })
            } else {
                self.activityIndicator.stopAnimating()
            }
        }
        
        configurePresenter()
    }
    
    internal func configurePresenter() {
        presenter.completion =  { [weak self] results in
            guard let self = self else { return }
            switch results {
            case .success(let terms):
                self.autoCompleteTerms = terms
                if !terms.isEmpty {
                    self.tableView.reloadData()
                    self.tableView.isHidden = false
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SearchTermViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateSearchField(false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        defer {
            textField.resignFirstResponder()
        }
        
        if !isNetworkReachable {
            showNetworkError()
            return true
        }
        
        switch (searchField.text?.isEmpty ?? true, locationField.text?.isEmpty ?? true) {
        case (true, true):
            animateSearchField()
        case (false, true):
            if !(locationEngine?.isLocationEnabled ?? false) && !locationField.isFirstResponder {
                locationField.becomeFirstResponder()
            } else {
                navigateToSearch(term: searchField.text ?? "", location: .coord(locationEngine?.coordinates))
            }
        case (false, false):
            navigateToSearch(term: searchField.text ?? "", location: .name(locationField.text ?? ""))
        default:
            break
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var searchTerm = ""
        if let text = textField.text, let textRange = Range(range, in: text) {
            searchTerm = text.replacingCharacters(in: textRange, with: string)
        }
        
        if textField == searchField {
            presenter.fetchAutoCompleteTerms(searchTerm)
            if searchTerm.isEmpty {
                tableView.isHidden = true
                autoCompleteTerms.removeAll()
                tableView.reloadData()
            }
        }
        
        return true
    }
}

extension SearchTermViewController {
    
    private func animateSearchField(_ isCentered: Bool = true) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.stackViewCentreYConstraint.isActive = isCentered
            self.view.layoutIfNeeded()
        }
    }
    
    internal func navigateToSearch(term: String, location: LocationValue) {
        self.searchTerm = term
        self.location = location
        performSegue(withIdentifier: Constants.Segue.showSearchResults.rawValue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let searchResultViewController = segue.destination as? SearchResultViewController else {
            fatalError("Cannot find Search Result View Controller")
        }
        
        defer { searchField.resignFirstResponder() }
        
        searchResultViewController.searchTerm = searchTerm
        searchResultViewController.location = location
    }
}
