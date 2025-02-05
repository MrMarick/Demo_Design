//
//  Extension+Button.swift
//  Demo_Design
//
//  Created by Karma Strategies on 03/02/25.
//

import Foundation
import UIKit

extension UIButton {
    func addBottomBorder(borderWidth: CGFloat = 1) {
        layer.sublayers?.removeAll(where: { $0.name == "bottomBorder" })
        
        let bottomBorder = CALayer()
        bottomBorder.name = "bottomBorder"
        bottomBorder.frame = CGRect(x: 0, y: self.frame.height - borderWidth, width: self.frame.width, height: borderWidth)
        bottomBorder.backgroundColor = self.tintColor.cgColor
        layer.addSublayer(bottomBorder)
    }
}

