//
//  Helper.swift
//  Demo_Design
//
//  Created by Karma Strategies on 04/02/25.
//

import Foundation
import UIKit
import Charts
final class Helper {
    private init(){}
    static let shared = Helper()

    func setupBarChart(barChartView: BarChartView, xAxisValue: [String], yAxisValue: [Double], colors: [UIColor], cornerRadius: CGFloat = 10, showValue: Bool = false, showAvgLine: Bool = false) {
        barChartView.rightAxis.enabled = false
        barChartView.doubleTapToZoomEnabled = false
        barChartView.legend.enabled = false
        
        let yaxis = barChartView.leftAxis
        yaxis.drawGridLinesEnabled = false
        yaxis.axisMinimum = 0
        yaxis.axisMaximum = 500
        yaxis.drawLabelsEnabled = false
        barChartView.rightAxis.enabled = false
        
        let xaxis = barChartView.xAxis
        xaxis.labelPosition = .bottom
        xaxis.valueFormatter = IndexAxisValueFormatter(values: xAxisValue)
        xaxis.drawGridLinesEnabled = false
        xaxis.drawLabelsEnabled = true
        xaxis.labelTextColor = .white
        barChartView.leftAxis.enabled = showAvgLine
        barChartView.animate(xAxisDuration: 1.5)
        var dataEntries: [BarChartDataEntry] = []
        var totalValue: Double = 0

        for i in 0..<xAxisValue.count {
            totalValue += yAxisValue[i]
            let entry = BarChartDataEntry(x: Double(i), y: yAxisValue[i])
            dataEntries.append(entry)
        }
        
        let set = BarChartDataSet(entries: dataEntries, label: "XP")
        set.drawValuesEnabled = true
        set.colors = colors
        let data = BarChartData(dataSet: set)
        data.setDrawValues(false)
        data.barWidth = 0.4
        barChartView.data = data
        if showAvgLine {
            let averageValue = totalValue / Double(yAxisValue.count)
            let limitLine = ChartLimitLine(limit: averageValue, label: "")
            limitLine.lineWidth = 1
            limitLine.lineDashLengths = [5, 5]
            limitLine.lineColor = .white
            limitLine.labelPosition = .rightBottom
            limitLine.valueTextColor = .white
            yaxis.addLimitLine(limitLine)
        }

        barChartView.renderer = RoundedTopBarChartRenderer(
            dataProvider: barChartView,
            animator: barChartView.chartAnimator,
            viewPortHandler: barChartView.viewPortHandler,
            cornerRadius: cornerRadius,
            gradientColors: colors,
            showValue: showValue
        )

    }

}



