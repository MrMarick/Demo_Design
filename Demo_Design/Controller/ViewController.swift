//
//  ViewController.swift
//  Demo_Design
//
//  Created by Karma Strategies on 02/02/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var shortcutCollectionView: UICollectionView!

    @IBOutlet weak var featureCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightAnchor: NSLayoutConstraint!
    var shortCutData: [ShortcutItem] = []{
        didSet{
            shortcutCollectionView.reloadData()
        }
    }
    
    @IBOutlet weak var editShortcutBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let shortcutCollectionViewWidth = (shortcutCollectionView.frame.size.width - 50)/4
        setupCollectionView(collectionView: shortcutCollectionView, height: shortcutCollectionViewWidth, width: shortcutCollectionViewWidth)
        let featureCollectionViewWidth = (shortcutCollectionView.frame.size.width - 50)
        setupCollectionView(collectionView: featureCollectionView, height: featureCollectionViewWidth, width: featureCollectionViewWidth, scrollDirection: .horizontal)
        editShortcutBtn.isHidden = true
        shortCutData = CollectionViewData.shared.shortcutData + CollectionViewData.shared.moreData
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditShortcuts" {
            if let vc = segue.destination as? EditShortcutsVC {
                vc.viewDismissed = {
                    self.collectionViewHeightAnchor.constant = 100
                    self.editShortcutBtn.isHidden = true
                    self.shortCutData = CollectionViewData.shared.shortcutData + CollectionViewData.shared.moreData
                }
                vc.modalPresentationStyle = .pageSheet
                vc.isModalInPresentation = true
                let fixedHeightDetent = UISheetPresentationController.Detent.custom { context in
                                    return 500
                }
                if let sheet = vc.sheetPresentationController {
                    sheet.detents = [fixedHeightDetent]
                    sheet.preferredCornerRadius = 20
                }
            }
        }
    }

    @IBAction func editShortcutBtnActn(_ sender: Any) {
        self.performSegue(withIdentifier: "EditShortcuts", sender: self)
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1{
            return shortCutData.count
        } else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCollectionViewCell", for: indexPath) as! ExploreCollectionViewCell
            cell.layer.cornerRadius = 10
            cell.img.image = UIImage(named: shortCutData[indexPath.row].imageName)
            cell.lbl.text = shortCutData[indexPath.row].title
            return cell

         } else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            cell.layer.cornerRadius = 10
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 3{
            if shortCutData.count <= 4{
                collectionViewHeightAnchor.constant = 300
                editShortcutBtn.isHidden = false
                shortCutData = CollectionViewData.shared.shortcutData + CollectionViewData.shared.closeData + CollectionViewData.shared.exploreData
            }else {
                collectionViewHeightAnchor.constant = 100
                editShortcutBtn.isHidden = true
                shortCutData = CollectionViewData.shared.shortcutData + CollectionViewData.shared.moreData
            }
        }
    }
    
    
}
extension ViewController{
    func setupCollectionView(collectionView: UICollectionView, height: Double, width: Double, lineSpacing: Double = 10, scrollDirection: UICollectionView.ScrollDirection = .vertical){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = lineSpacing
        collectionView.collectionViewLayout = layout
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = scrollDirection
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == featureCollectionView {
            let centerX = scrollView.contentOffset.x + scrollView.bounds.width / 2
            
            for cell in featureCollectionView.visibleCells {
                let cellFrame = cell.convert(cell.bounds, to: scrollView)
                let distanceFromCenter = abs(centerX - cellFrame.midX)
                let scale = max(0.8, 1 - (distanceFromCenter / scrollView.bounds.width))
                
                // Apply the scaling and alpha effect
                cell.transform = CGAffineTransform(scaleX: scale, y: scale)
                cell.alpha = scale
            }
        }
    }

}
