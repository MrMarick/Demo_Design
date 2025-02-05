//
//  InsightVC.swift
//  Demo_Design
//
//  Created by Karma Strategies on 04/02/25.
//

import UIKit
import Charts
class InsightVC: UIViewController {
    @IBOutlet weak var weeklyBarChart: BarChartView!
    @IBOutlet weak var dailyBarChart: BarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Helper.shared.setupBarChart(barChartView: weeklyBarChart, xAxisValue: ["", ""], yAxisValue: ChartData.weeklyChartData, colors: ChartData.weeklyChartBarColor, showValue: true)
        Helper.shared.setupBarChart(barChartView: dailyBarChart, xAxisValue: ChartData.dailyXaxisData, yAxisValue: ChartData.dailyYaxisData, colors: ChartData.dailyChartBarColor, showAvgLine: true)
    }
    
}
extension InsightVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedCollectionViewCell", for: indexPath) as! RecommendedCollectionViewCell
        cell.layer.cornerRadius = 15
        if indexPath.row == 1 {
            cell.img.image = UIImage(named: "journal 1")
            cell.term.text = "Entries"
            cell.title.text = "Journal"
            cell.val1.text = "200"
            cell.val2.text = "700"
            cell.title.textColor = UIColor(hex: "DE3278")
            cell.val1.textColor = UIColor(hex: "DE3278")
            cell.val2.textColor = UIColor(hex: "DE3278")
        }else {
            cell.img.image = UIImage(named: "meditation1")
            cell.term.text = "Sessions"
            cell.title.text = "Meditation"
            cell.val1.text = "200"
            cell.val2.text = "700"
            cell.title.textColor = UIColor(hex: "5CC899")
            cell.val1.textColor = UIColor(hex: "5CC899")
            cell.val2.textColor = UIColor(hex: "5CC899")

        }
        return cell
    }
}
