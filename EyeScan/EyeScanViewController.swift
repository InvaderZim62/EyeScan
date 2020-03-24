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
    
    lazy var focalPointView = FocalPointView(frame: CGRect(x: imageView.frame.midX, y: imageView.frame.midY, width: 10, height: 10))
    lazy var initialImagePosition = CGPoint(x: view.frame.width, y: view.frame.midY)  // center of image on right edge of screen
    lazy var finalImagePosition = CGPoint(x: 0, y: view.frame.midY)  // center of image on left edge of screen

    var imageView = UIImageView()
    
    @IBOutlet weak var leftBlockView: UIView!  // pws: delete these after tesing
    @IBOutlet weak var rightBlockView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "canyon")
        imageView.sizeToFit()  // pws: needed?
        imageView.addSubview(focalPointView)
        view.addSubview(imageView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        imageView.center = initialImagePosition
        leftBlockView.backgroundColor = UIColor.clear  // pws: make clear during testing
        rightBlockView.backgroundColor = UIColor.clear
        leftBlockView.layer.zPosition = 1
        rightBlockView.layer.zPosition = 1
        moveImageBackAndForth()
    }
    
    func moveImageBackAndForth() {
        UIView.transition(with: imageView,
                          duration: Constants.scrollDuration,
                          options: [],
                          animations: {
                            self.imageView.center = self.finalImagePosition
        },
                          completion: { _ in
                            UIView.transition(with: self.imageView,
                                              duration: Constants.scrollDuration,
                                              options: [],
                                              animations: {
                                                self.imageView.center = self.initialImagePosition
                            },
                                              completion: { _ in
                                                self.moveImageBackAndForth()
                            })

        })
    }
}

