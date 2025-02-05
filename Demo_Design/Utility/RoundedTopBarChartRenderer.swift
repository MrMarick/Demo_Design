//
//  RoundedTopBarChartRenderer.swift
//  Demo_Design
//
//  Created by Karma Strategies on 04/02/25.
//

import Foundation
import Charts
import UIKit

class RoundedTopBarChartRenderer: BarChartRenderer {
    private let cornerRadius: CGFloat
    private let gradientColors: [UIColor]
    private let showValue: Bool

    init(dataProvider: BarChartDataProvider, animator: Animator, viewPortHandler: ViewPortHandler, cornerRadius: CGFloat, gradientColors: [UIColor], showValue: Bool) {
        self.cornerRadius = cornerRadius
        self.gradientColors = gradientColors
        self.showValue = showValue
        super.init(dataProvider: dataProvider, animator: animator, viewPortHandler: viewPortHandler)
    }

    override func drawDataSet(context: CGContext, dataSet: BarChartDataSetProtocol, index: Int) {
        guard let barDataProvider = dataProvider else { return }

        let trans = barDataProvider.getTransformer(forAxis: dataSet.axisDependency)
        let phaseY = animator.phaseY
        let barWidthHalf = CGFloat(barDataProvider.barData?.barWidth ?? 0) / 2.0

        for i in 0 ..< dataSet.entryCount {
            guard let entry = dataSet.entryForIndex(i) as? BarChartDataEntry else { continue }

            let left = CGFloat(entry.x - barWidthHalf)
            let right = CGFloat(entry.x + barWidthHalf)
            let top = CGFloat(entry.y * phaseY)
            let bottom: CGFloat = 0

            var barRect = CGRect(x: left, y: top, width: right - left, height: bottom - top)

            trans.rectValueToPixel(&barRect)

            let path = UIBezierPath(
                roundedRect: barRect,
                byRoundingCorners: [.topLeft, .topRight],
                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
            )

            context.saveGState()
            context.addPath(path.cgPath)
            context.clip()

            let gradientCGColors = gradientColors.map { $0.cgColor } as CFArray
            let colorLocations: [CGFloat] = [0.0, 1.0]
            guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientCGColors, locations: colorLocations) else { return }

            let startPoint = CGPoint(x: barRect.midX, y: barRect.minY)
            let endPoint = CGPoint(x: barRect.midX, y: barRect.maxY)
            context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])

            context.restoreGState()

            if showValue {
                let valueText = String(format: "%.0f", entry.y)
                let valueFont = UIFont.systemFont(ofSize: 17, weight: .medium)
                let valueTextColor = UIColor.black

                let attributes: [NSAttributedString.Key: Any] = [
                    .font: valueFont,
                    .foregroundColor: valueTextColor
                ]

                let textSize = valueText.size(withAttributes: attributes)
                let textPosition = CGPoint(x: barRect.midX - textSize.width / 2, y: barRect.minY + textSize.height)

                valueText.draw(at: textPosition, withAttributes: attributes)
            }
        }
    }
}
