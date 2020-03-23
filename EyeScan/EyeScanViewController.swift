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
    
    lazy var initialScrollPoint = CGPoint(x: -view.frame.width / 2, y: 0)  // left edge of image in center of screen
    lazy var finalScrollPoint = CGPoint(x: imageView.frame.width - view.frame.width / 2, y: 0)  // right edge of image in center of screen

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "canyon")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentOffset = initialScrollPoint  // start with image right
        scrollImageBackAndForth()
    }
    
    func scrollImageBackAndForth() {
        UIView.animate(withDuration: Constants.scrollDuration,
                       delay: 0,
                       options: [],
                       animations: {
                        self.scrollView.contentOffset = self.finalScrollPoint  // scroll left
        },
                       completion: { _ in
                        UIView.animate(withDuration: Constants.scrollDuration,
                                       delay: 0,
                                       options: [],
                                       animations: {
                                        self.scrollView.contentOffset = self.initialScrollPoint  // scroll right
                        },
                                       completion: { _ in
                                        self.scrollImageBackAndForth()
                        })
        })
    }

}

