//
//  PresentData.swift
//  Recaminder
//
//  Created by timofey makhlay on 2/27/19.
//  Copyright © 2019 Timofey Makhlay. All rights reserved.
//

import UIKit

class PresentDataVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "iPhone XS Copy")
        view.addSubview(imageView)
        imageView.fillSuperview()
        imageView.contentMode = .scaleAspectFit
    }
}
