//
//  RoundImageView.swift
//  WadiniApp
//
//  Created by Sherif Kamal on 10/15/18.
//  Copyright © 2018 Sherif Kamal. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {
    
    override func awakeFromNib() {
        setupView()
    }

    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
   
}
