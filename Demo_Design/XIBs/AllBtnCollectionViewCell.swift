//
//  AllBtnCollectionViewCell.swift
//  Demo_Design
//
//  Created by Karma Strategies on 03/02/25.
//

import UIKit

class AllBtnCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    var addShortcut: (() -> Void)?
    @IBAction func addBtnActn(_ sender: Any) {
        addShortcut?()
    }
}
