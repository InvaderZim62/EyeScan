//
//  EyeScanViewController.swift
//  EyeScan
//
//  Created by Phil Stern on 3/23/20.
//  Copyright © 2020 Phil Stern. All rights reserved.
//

import UIKit

struct Constants {
    static let scrollDuration = 1.2  // seconds to scroll in one direction
    static let showImage = false  // true for debugging
}

enum PointState: Int {
    case noPoints
    case greenPoint
    case redPoint
    case bothPoints
}

class EyeScanViewController: UIViewController {
    
    let imageView = UIImageView()
    let greenPointView = FocalPointView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    let redPointView = FocalPointView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    var pointState = PointState.bothPoints
    var rightPosition = CGPoint()
    var leftPosition = CGPoint()
    
    @IBOutlet weak var rightBlockView: UIView!
    @IBOutlet weak var leftBlockView: UIView!
    
    override var prefersStatusBarHidden: Bool { return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "canyon")
        imageView.sizeToFit()
        view.addSubview(imageView)
        
        greenPointView.color = UIColor(displayP3Red: 0, green: 0.5, blue: 0, alpha: 1)
        greenPointView.layer.zPosition = 2
        view.addSubview(greenPointView)
        
        redPointView.color = UIColor(displayP3Red: 0.5, green: 0, blue: 0, alpha: 1)
        redPointView.layer.zPosition = 2
        view.addSubview(redPointView)
        
        rightBlockView.layer.zPosition = 1
        leftBlockView.layer.zPosition = 1  // place blocks between imageView and point views
        if Constants.showImage {
            rightBlockView.backgroundColor = UIColor.clear
            leftBlockView.backgroundColor = UIColor.clear
        }
    }
    
    override func viewDidLayoutSubviews() {
        var percentScreen: CGFloat = 0.9  // width of screen used by focal point
        if view.frame.width < 500 { percentScreen = 1.0 }
        rightPosition = CGPoint(x: percentScreen * view.frame.width, y: view.frame.midY)
        leftPosition = CGPoint(x: (1 - percentScreen) * view.frame.width, y: view.frame.midY)
        imageView.center = rightPosition
        greenPointView.center = rightPosition
        redPointView.center = leftPosition
    }

    override func viewDidAppear(_ animated: Bool) {
        UIScreen.main.brightness = 1.0  // full brightness (must reset brightness manually)
        moveViewBackAndForth(imageView, rightToLeft: false)
        moveViewBackAndForth(greenPointView, rightToLeft: false)
        moveViewBackAndForth(redPointView, rightToLeft: true)
    }
    
    private func moveViewBackAndForth(_ view: UIView, rightToLeft: Bool) {
        UIView.transition(with: view,
                          duration: Constants.scrollDuration,
                          options: [],
                          animations: {
                            view.center = rightToLeft ? self.rightPosition : self.leftPosition
        },
                          completion: { _ in
                            UIView.transition(with: view,
                                              duration: Constants.scrollDuration,
                                              options: [],
                                              animations: {
                                                view.center = rightToLeft ? self.leftPosition : self.rightPosition
                            },
                                              completion: { _ in
                                                self.moveViewBackAndForth(view, rightToLeft: rightToLeft)
                            })

        })
    }

    @IBAction func screenTapped(_ sender: UITapGestureRecognizer) {
        switch pointState {
        case .noPoints:
            pointState = .bothPoints
            greenPointView.isHidden = false
            redPointView.isHidden = false
        case .bothPoints:
            pointState = .greenPoint
            greenPointView.isHidden = false
            redPointView.isHidden = true
        case .greenPoint:
            pointState = .redPoint
            greenPointView.isHidden = true
            redPointView.isHidden = false
        case .redPoint:
            pointState = .noPoints
            greenPointView.isHidden = true
            redPointView.isHidden = true
        }
    }
}

