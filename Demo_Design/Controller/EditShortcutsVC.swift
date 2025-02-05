//
//  EditShortcutsVC.swift
//  Demo_Design
//
//  Created by Karma Strategies on 03/02/25.
//

import UIKit

class EditShortcutsVC: UIViewController {
    @IBOutlet weak var shortcutBtnCollectionView: UICollectionView!
    @IBOutlet weak var allBtnCollectionView: UICollectionView!
    var shortcutBtns: [ShortcutItem] = CollectionViewData.shared.shortcutData{
        didSet{
            shortcutBtnCollectionView.reloadData()
            allBtnCollectionView.reloadData()
        }
    }
    var allBtns: [ShortcutItem] = CollectionViewData.shared.exploreData{
        didSet{
            shortcutBtnCollectionView.reloadData()
            allBtnCollectionView.reloadData()
        }
    }
    var viewDismissed: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

        shortcutBtnCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        allBtnCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    

    @IBAction func closePopup(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveShortcutBtnActn(_ sender: Any) {
        if shortcutBtns.count == 3{
            CollectionViewData.shared.shortcutData = shortcutBtns
            CollectionViewData.shared.exploreData = allBtns
            self.dismiss(animated: true) {
                self.viewDismissed?()
            }
        }else {
            self.showToast(message: "Add at least 3 shortcuts")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension EditShortcutsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return shortcutBtns.count
        }else{
            return allBtns.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShortcutBtnCollectionViewCell", for: indexPath) as! ShortcutBtnCollectionViewCell
            cell.layer.cornerRadius = 10
            cell.img.image = UIImage(named: shortcutBtns[indexPath.row].imageName)
            cell.lbl.text = shortcutBtns[indexPath.row].title
            cell.removeShortcut = {
                self.allBtns.append(self.shortcutBtns[indexPath.row])
                self.shortcutBtns.remove(at: indexPath.item)
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllBtnCollectionViewCell", for: indexPath) as! AllBtnCollectionViewCell
            cell.layer.cornerRadius = 10
            cell.img.image = UIImage(named: allBtns[indexPath.row].imageName)
            cell.lbl.text = allBtns[indexPath.row].title
            cell.addShortcut = {
                self.shortcutBtns.append(self.allBtns[indexPath.row])
                self.allBtns.remove(at: indexPath.item)
            }
            if shortcutBtns.count >= 3{
                cell.addBtn.isHidden = true
            }else {
                cell.addBtn.isHidden = false
            }
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1{
            let width = (collectionView.frame.size.width - 30)/4
            return CGSize(width: width, height: width)
        }else{
            let width = (collectionView.frame.size.width - 50)/4
            return CGSize(width: width, height: width)
        }
    }
    }
    
