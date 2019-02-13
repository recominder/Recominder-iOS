//
//  TestViewController.swift
//  Recaminder
//
//  Created by timofey makhlay on 2/12/19.
//  Copyright © 2019 Timofey Makhlay. All rights reserved.
//

import UIKit
import Lottie

class TestVC: UIViewController {
    
    // Progress bar animation
    let progressBarAnimation = LOTAnimationView(name: "progress")
    var progress :CGFloat = CGFloat(0.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(progressBarAnimation)
        progressBarAnimation.centerOfView(to: view)
        
        progressBarAnimation.viewConstantRatio(widthToHeightRatio: 1, width: .init(width: 200
            , height: 100))
        
        progressBarAnimation.contentMode = .scaleAspectFit
        
//        progressBarAnimation.play()
        

        let tap = UITapGestureRecognizer(target: self, action: #selector(playAnimation(rec:)))
        
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func playAnimation(rec:UITapGestureRecognizer) {
//        var translation = rec.translation(in: self.view)
//        var prog = translation.x / self.view.bounds.width
        if progress >= 0.5 {
            progress = 1
            progressBarAnimation.play(fromProgress: 0.5, toProgress: 1.0, withCompletion: nil)
        } else {
            
            progressBarAnimation.play(fromProgress: progress, toProgress: progress + 0.1, withCompletion: nil)
            progress += 0.1
        }
        print(progress)
    }
}

