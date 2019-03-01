//
//  TestViewController.swift
//  Recaminder
//
//  Created by timofey makhlay on 2/12/19.
//  Copyright © 2019 Timofey Makhlay. All rights reserved.
//

import UIKit
import Lottie
import HealthKit

class TestVC: UIViewController {
    
    // Progress bar animation
    let progressBarAnimation = LOTAnimationView(name: "background")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.4823529412, green: 0.9333333333, blue: 0.8117647059, alpha: 1)
        view.addSubview(progressBarAnimation)
        progressBarAnimation.fillSuperview()
        progressBarAnimation.loopAnimation = true

        progressBarAnimation.contentMode = .scaleAspectFit
        progressBarAnimation.play()
    }
}
