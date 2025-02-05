//
//  ShortcutBtnCollectionViewCell.swift
//  Demo_Design
//
//  Created by Karma Strategies on 03/02/25.
//

import UIKit

class ShortcutBtnCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    var removeShortcut: (() -> Void)?
    @IBAction func removeBtnActn(_ sender: Any) {
        removeShortcut?()
    }
}
