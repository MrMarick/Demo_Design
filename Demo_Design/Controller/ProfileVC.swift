//
//  ProfileVC.swift
//  Demo_Design
//
//  Created by Karma Strategies on 03/02/25.
//

import UIKit

class ProfileVC: UIViewController {
    @IBOutlet weak var libraryBtn: UIButton!
    @IBOutlet weak var insightsBtn: UIButton!
    @IBOutlet weak var libraryContainerView: UIView!
    @IBOutlet weak var insightContainerView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var stackViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerViewTopConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        libraryBtn.addBottomBorder(borderWidth: 2)
        insightsBtn.addBottomBorder(borderWidth: 1)
        libraryContainerView.isHidden = false
        insightContainerView.isHidden = true
    }
    

    @IBAction func libraryBtnActn(_ sender: Any) {
        libraryBtn.tintColor = .white
        insightsBtn.tintColor = .lightGray
        libraryBtn.addBottomBorder(borderWidth: 2)
        insightsBtn.addBottomBorder(borderWidth: 1)
        libraryContainerView.isHidden = false
        insightContainerView.isHidden = true
    }
    @IBAction func insightsBtnActn(_ sender: Any) {
        insightsBtn.tintColor = .white
        libraryBtn.tintColor = .lightGray
        insightsBtn.addBottomBorder(borderWidth: 2)
        libraryBtn.addBottomBorder(borderWidth: 1)
        libraryContainerView.isHidden = true
        insightContainerView.isHidden = false
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
