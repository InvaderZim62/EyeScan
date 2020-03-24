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
    lazy var initialScrollPosition = CGPoint(x: -view.frame.width / 2, y: 0)  // left edge of image in center of screen
    lazy var finalScrollPosition = CGPoint(x: imageView.frame.width - view.frame.width / 2, y: 0)  // right edge of image in center of screen

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var leftBlockView: UIView!  // pws: delete these after tesing
    @IBOutlet weak var rightBlockView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "canyon")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        imageView.addSubview(focalPointView)
        scrollView.contentOffset = initialScrollPosition  // start with image right
        leftBlockView.backgroundColor = UIColor.clear  // pws: make clear during testing
        leftBlockView.isUserInteractionEnabled = false  // pws: temporary - allow swipe to pass though to scroll view
        rightBlockView.backgroundColor = UIColor.clear
        rightBlockView.isUserInteractionEnabled = false
//        scrollImageBackAndForth()
    }
    
    func scrollImageBackAndForth() {
        UIView.animate(withDuration: Constants.scrollDuration,
                       delay: 0,
                       options: [],
                       animations: {
                        self.scrollView.contentOffset = self.finalScrollPosition  // scroll left
        },
                       completion: { _ in
                        UIView.animate(withDuration: Constants.scrollDuration,
                                       delay: 0,
                                       options: [],
                                       animations: {
                                        self.scrollView.contentOffset = self.initialScrollPosition  // scroll right
                        },
                                       completion: { _ in
                                        self.scrollImageBackAndForth()
                        })
        })
    }

}

