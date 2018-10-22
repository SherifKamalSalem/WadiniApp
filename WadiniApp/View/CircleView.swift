
//
//  CircleView.swift
//  WadiniApp
//
//  Created by Sherif Kamal on 10/15/18.
//  Copyright © 2018 Sherif Kamal. All rights reserved.
//

import UIKit

class CircleView: UIView {

    @IBInspectable var borderColor: UIColor? {
        didSet{
            
        }
    }
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderWidth = 1.5
        self.layer.borderColor = borderColor?.cgColor
    }
}
