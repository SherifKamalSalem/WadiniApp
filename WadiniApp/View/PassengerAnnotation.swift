//
//  PassengerAnnotation.swift
//  WadiniApp
//
//  Created by Sherif Kamal on 10/18/18.
//  Copyright © 2018 Sherif Kamal. All rights reserved.
//

import Foundation
import MapKit

class PassengerAnnotation: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var key: String
    
    init(coordinate: CLLocationCoordinate2D, key: String) {
        self.coordinate = coordinate
        self.key = key
        super.init()
    }
}
