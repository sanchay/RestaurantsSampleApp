//
//  String+Extensions.swift
//  RBCTest
//
//  Created by Sanchay Banerjee on 2020-07-24.
//  Copyright © 2020 Sanchay Banerjee. All rights reserved.
//

import UIKit

extension String {
    
    public var escapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let bottomPadding: CGFloat = 8
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [.font: font], context: nil)
        return ceil(boundingBox.height) + bottomPadding
    }
    
    var trimmed: String {
        return self.trimmingCharacters(in: CharacterSet.newlines)
    }
}
