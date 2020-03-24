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
}

class EyeScanViewController: UIViewController {
    
    let imageView = UIImageView()
    let focalPointView = FocalPointView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    var rightPosition = CGPoint()
    var leftPosition = CGPoint()
    
    @IBOutlet weak var leftBlockView: UIView!  // pws: delete these after tesing
    @IBOutlet weak var rightBlockView: UIView!
    
    override var prefersStatusBarHidden: Bool { return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "canyon")
        imageView.sizeToFit()
        view.addSubview(imageView)
        view.addSubview(focalPointView)
        focalPointView.layer.zPosition = 2
        leftBlockView.layer.zPosition = 1  // place blocks between imageView and focalPointView
        rightBlockView.layer.zPosition = 1
//        leftBlockView.backgroundColor = UIColor.clear  // pws: make clear during testing
//        rightBlockView.backgroundColor = UIColor.clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIScreen.main.brightness = 1.0  // full brightness (must reset brightness manually)
        moveViewBackAndForth(imageView)
        moveViewBackAndForth(focalPointView)
    }
    
    override func viewDidLayoutSubviews() {
        var percentScreen: CGFloat = 0.9  // width of screen used by focal point
        if view.frame.width < 500 { percentScreen = 1.0 }
        rightPosition = CGPoint(x: percentScreen * view.frame.width, y: view.frame.midY)
        leftPosition = CGPoint(x: (1 - percentScreen) * view.frame.width, y: view.frame.midY)
        imageView.center = rightPosition
        focalPointView.center = rightPosition
    }
    
    private func moveViewBackAndForth(_ view: UIView) {
        UIView.transition(with: view,
                          duration: Constants.scrollDuration,
                          options: [],
                          animations: {
                            view.center = self.leftPosition
        },
                          completion: { _ in
                            UIView.transition(with: view,
                                              duration: Constants.scrollDuration,
                                              options: [],
                                              animations: {
                                                view.center = self.rightPosition
                            },
                                              completion: { _ in
                                                self.moveViewBackAndForth(view)
                            })

        })
    }
    
    @IBAction func screenTapped(_ sender: UITapGestureRecognizer) {
        focalPointView.isHidden = !focalPointView.isHidden
    }
}

