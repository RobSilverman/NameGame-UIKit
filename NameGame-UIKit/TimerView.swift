//
//  TimerView.swift
//  NameGame-UIKit
//
//  Created by Robert Silverman on 2/22/21.
//  Copyright © 2021 Robert Silverman. All rights reserved.
//

import UIKit

class TimerView: UIView {
    
    var currentProgress: Double = 0

    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            context.setLineWidth(2)
            UIColor.lightGray.set()
            
            let center = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
            let radius = (frame.size.width - 5)/2
            
            //Draw incomplete (light gray) circle
            context.addArc(center: center, radius: radius, startAngle: -(0.5 * .pi), endAngle: .pi * 2.0 * CGFloat(currentProgress) - (0.5 * .pi), clockwise: true)
            context.strokePath()
            
            //Draw complete (blue) section overtop
            UIColor(named: "MenuButtonColor")?.set()
            context.addArc(center: center, radius: radius, startAngle: .pi * 2.0 * CGFloat(currentProgress) - (0.5 * .pi), endAngle: .pi * 2.0 - (0.5 * .pi), clockwise: true)
            context.strokePath()
        }
    }

}
