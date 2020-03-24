//
//  FocalPointView.swift
//  EyeScan
//
//  Created by Phil Stern on 3/23/20.
//  Copyright © 2020 Phil Stern. All rights reserved.
//

import UIKit

class FocalPointView: UIView {

    override func draw(_ rect: CGRect) {
        backgroundColor = UIColor.clear
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = 0.44 * bounds.width
        let circle = UIBezierPath(arcCenter: center,
                                  radius: radius,
                                  startAngle: 0.0,
                                  endAngle: 2.0 * CGFloat.pi,
                                  clockwise: true)
        UIColor.black.setFill()
        circle.fill()
    }
}
