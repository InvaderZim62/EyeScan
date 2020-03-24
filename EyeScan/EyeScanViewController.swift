//
//  EyeScanViewController.swift
//  EyeScan
//
//  Created by Phil Stern on 3/23/20.
//  Copyright © 2020 Phil Stern. All rights reserved.
//

import UIKit

struct Constants {
    static let scrollDuration = 1.0  // seconds to scroll in one direction
}

class EyeScanViewController: UIViewController {
    
    lazy var focalPointView = FocalPointView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    lazy var initialImagePosition = CGPoint(x: view.frame.width, y: view.frame.midY)  // center of image on right edge of screen
    lazy var finalImagePosition = CGPoint(x: 0, y: view.frame.midY)  // center of image on left edge of screen

    var imageView = UIImageView()
    
    @IBOutlet weak var leftBlockView: UIView!  // pws: delete these after tesing
    @IBOutlet weak var rightBlockView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "canyon")
        imageView.sizeToFit()
        view.addSubview(focalPointView)
        view.addSubview(imageView)

//        leftBlockView.backgroundColor = UIColor.clear  // pws: make clear during testing
//        rightBlockView.backgroundColor = UIColor.clear
        leftBlockView.layer.zPosition = 1  // place between imageView and focalPointView
        rightBlockView.layer.zPosition = 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        imageView.center = initialImagePosition
        focalPointView.center = initialImagePosition
        focalPointView.layer.zPosition = 2
        moveViewBackAndForth(imageView)
        moveViewBackAndForth(focalPointView)
    }
    
    func moveViewBackAndForth(_ view: UIView) {
        UIView.transition(with: view,
                          duration: Constants.scrollDuration,
                          options: [],
                          animations: {
                            view.center = self.finalImagePosition
        },
                          completion: { _ in
                            UIView.transition(with: view,
                                              duration: Constants.scrollDuration,
                                              options: [],
                                              animations: {
                                                view.center = self.initialImagePosition
                            },
                                              completion: { _ in
                                                self.moveViewBackAndForth(view)
                            })

        })
    }
}

