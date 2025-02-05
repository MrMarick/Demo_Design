//
//  Extension+Color.swift
//  Demo_Design
//
//  Created by Karma Strategies on 04/02/25.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String) {
        var hexString = hex
        // Remove `#` if it exists
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        let scanner = Scanner(string: hexString)
        scanner.scanLocation = 0
        
        var rgbColorValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbColorValue)
        
        let r = (rgbColorValue & 0xff0000) >> 16
        let g = (rgbColorValue & 0xff00) >> 8
        let b = rgbColorValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    convenience init(gradientFrom startColor: UIColor, to endColor: UIColor, size: CGSize = CGSize(width: 1, height: 100)) {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        let colors = [startColor.cgColor, endColor.cgColor] as CFArray
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors, locations: [0.0, 1.0])!

        context?.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: size.height), options: [])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        self.init(patternImage: image!)
    }


}
