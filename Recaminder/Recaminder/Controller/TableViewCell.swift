//
//  TableViewCell.swift
//  Recaminder
//
//  Created by timofey makhlay on 3/4/19.
//  Copyright © 2019 Timofey Makhlay. All rights reserved.
//

import UIKit

struct PresentableData {
    var img:UIImage
    var title:String
    var amount:String
    
    init(img:UIImage=#imageLiteral(resourceName: "signupbox"), title:String="",amount:String="") {
        self.img = img
        self.title = title
        self.amount = amount
    }
}

class TableViewCell: UITableViewCell {
    
    let amountContainer: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 15
        return view
    }()
    
    // Title
    var titleLabel: UITextView = {
        var title = UITextView()
//        title.text = "Error"
        title.font = UIFont(name: "AvenirNext-Medium", size: 27)
        title.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        title.backgroundColor = nil
        title.textAlignment = .center
        title.isEditable = false
        title.isSelectable = false
        title.isScrollEnabled = false
        return title
    }()
    
    // Amount
    var amountLabel: UITextView = {
        var title = UITextView()
//        title.text = "Error"
        title.font = UIFont(name: "AvenirNext-Medium", size: 31)
        title.textColor = #colorLiteral(red: 1, green: 0.7254901961, blue: 0.7137254902, alpha: 1)
        title.backgroundColor = nil
        title.textAlignment = .center
        title.isEditable = false
        title.isSelectable = false
        title.isScrollEnabled = false
        return title
    }()
    
    // Logo Image
    let currentImageView: UIImageView = {
        var newImage = UIImageView()
//        newImage.image = #imageLiteral(resourceName: "signupbox")
        newImage.contentMode = .scaleAspectFit
        return newImage
    }()
    
    // Background
    let background:UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.7254901961, blue: 0.7137254902, alpha: 1)
        view.layer.shadowRadius = 6
        view.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return view
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(background)
        background.fillSuperview()
        setUpLayout()
        
        
    }
    
    func setUpLayout() {
//        let stack = UIStackView(arrangedSubviews: [titleLabel, amountContainer])
//        stack.axis = .vertical
//        stack.spacing = 15
        
//        addSubview(stack)
        addSubview(titleLabel)
        addSubview(amountContainer)
        addSubview(amountLabel)
        addSubview(currentImageView)
//
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 40, left: 0, bottom: 0, right: 0))
        amountContainer.anchor(top: titleLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 20, left: 0, bottom: 0, right: 0),size: .init(width: 220, height: 60))
        amountContainer.centerHorizontalOfView(to: self)
        
        amountLabel.centerOfView(to: amountContainer)
//
        currentImageView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: amountContainer.leadingAnchor, padding: .init(top: 110, left: 0, bottom: 0, right: 30), size: .init(width: 35, height: 35))
    }
    
    
    // Required with initilizer
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
