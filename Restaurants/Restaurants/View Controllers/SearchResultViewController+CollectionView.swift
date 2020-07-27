//
//  SearchResultViewController+CollectionView.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-23.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import UIKit

extension SearchResultViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.Segue.showDetails.rawValue, sender: self)
    }
}

extension SearchResultViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurants?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionView.Cell.identifier.rawValue, for: indexPath) as? CollectionViewCell else {
            fatalError("Cannot deque collection view cell")
        }
        let restaurant = restaurants?[indexPath.row]
        cell.lblName.text = (restaurant?.name ?? "")
        cell.lblAddress.text = restaurant?.location.address
        cell.containerView.accessibilityValue = (cell.lblName.text ?? "") + "." + (cell.lblAddress.text ?? "")
        return cell
    }
}

extension SearchResultViewController: CustomLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForCellAtIndexPath indexPath:IndexPath) -> CGFloat {
        let width = UIScreen.main.bounds.size.width/2 - 20
        let name = (restaurants?[indexPath.row].name ?? "")
        let address = (restaurants?[indexPath.row].location.address ?? "")
        
        let nameFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
        let addressFont = UIFont.systemFont(ofSize: 15)
        
        let height =  name.height(withConstrainedWidth: width, font: nameFont) +
            address.height(withConstrainedWidth: width, font: addressFont)
        
        return height
    }
}
