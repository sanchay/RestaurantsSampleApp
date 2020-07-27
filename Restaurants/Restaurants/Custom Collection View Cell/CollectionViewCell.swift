//
//  CollectionViewCell.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-24.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width/2 - 20).isActive = true
        containerView.layer.cornerRadius = 5
        containerView.layer.borderColor = UIColor.gray.cgColor
        containerView.layer.borderWidth = 1
        containerView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        lblName.text = ""
        lblAddress.text = ""
        lblName.sizeToFit()
        lblAddress.sizeToFit()
    }
}
