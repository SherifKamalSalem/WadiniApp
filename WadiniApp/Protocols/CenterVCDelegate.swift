//
//  CenterVCDelegate.swift
//  WadiniApp
//
//  Created by Sherif Kamal on 10/15/18.
//  Copyright © 2018 Sherif Kamal. All rights reserved.
//

import UIKit

//This delegate is for animate Left Panel opened and closed
//2- toggle the left panel
//3- adding the HomeVC behind the LeftPanelVC while the  second toggled

protocol CenterVCDelegate {
    func toggleLeftPanel()
    func addLeftPanelViewController()
    func animateLeftPanel(shouldExpand: Bool)
}
