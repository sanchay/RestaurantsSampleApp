//
//  UIViewController+Extensions.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-26.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func showNetworkError(_ completion: (() -> Void)? = nil ) {
        showAlert(title: "Error", message: "Network not reachable", completion)
    }
    
    public func showErrorAlert(_ error: Error, _ completion: (() -> Void)? = nil) {
        self.showAlert(title: "Error", message: error.localizedDescription, completion)
    }
    
    public func showAlert(title: String, message: String, _ completion: (() -> Void)? ) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                completion?()
            })
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}
