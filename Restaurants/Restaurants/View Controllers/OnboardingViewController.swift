//
//  OnboardingViewController.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-21.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, NetworkReachable {
    
    @IBOutlet weak var btnUnderstand: UIButton!
    @IBOutlet weak var imageViewLocation: UIImageView!
    
    private var locationEngine: LocationEngine!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension OnboardingViewController {
    
    func configure() {
        btnUnderstand.layer.cornerRadius = Constants.Button.Layer.cornerRadius.rawValue
        
        if #available(iOS 13, *) {
            imageViewLocation.image = UIImage(systemName: Constants.Image.location.rawValue)
        }
    }
    
    @IBAction func didTapUnderstandButton(_ sender: Any) {
        if !isNetworkReachable {
            showNetworkError()
            return
        }
        defer {
            NavigationState().onBoarding = true
        }
        locationEngine = LocationEngine { [weak self] coords in
            guard let self = self else { return }
            self.performSegue(withIdentifier: Constants.Segue.showAutoComplete.rawValue, sender: self)
        }
    }
}

extension OnboardingViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let searchViewController = segue.destination as? SearchTermViewController else { return }
        searchViewController.locationEngine = locationEngine
    }
}
