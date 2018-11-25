//
//  LocationService.swift
//  WadiniApp
//
//  Created by Sherif Kamal on 11/22/18.
//  Copyright © 2018 Sherif Kamal. All rights reserved.
//

import Foundation
import Firebase
import SwiftLocation


class LocationService {
}


//    func startUpdatingLocation() {
//        self.locationManager?.startUpdatingLocation()
//    }
//
//    func stopUpdatingLocation() {
//        self.locationManager?.stopUpdatingLocation()
//    }
//
//    // CLLocationManagerDelegate
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        guard let location = locations.last else {
//            return
//        }
//
//        // singleton for get last location
//        self.lastLocation = location
//
//        // use for real time update location
//        updateLocation(currentLocation: location)
//    }
//
//    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
//        // do on error
//        updateLocationDidFailWithError(error: error)
//    }
//
//    // Private function
//    private func updateLocation(currentLocation: CLLocation){
//
//        guard let delegate = self.delegate else {
//            return
//        }
//
//        delegate.tracingLocation(currentLocation: currentLocation)
//    }
//
//    private func updateLocationDidFailWithError(error: NSError) {
//
//        guard let delegate = self.delegate else {
//            return
//        }
//
//        delegate.tracingLocationDidFailWithError(error: error)
//    }
//}
//    func checkLocationAuthStatus() {
//        if CLLocationManager.authorizationStatus() == .authorizedAlways {
//            manager?.startUpdatingLocation()
//        } else {
//            manager?.requestAlwaysAuthorization()
//        }
//    }
//
//}
//
////Extenstions
//extension LocationService: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == .authorizedAlways {
//            mapView.showsUserLocation = true
//            mapView.userTrackingMode = .follow
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
//        DataService.instance.driverIsOnTrip(driverKey: currentUserId!, handler: { (isOnTrip, driverKey, passengerKey) in
//            if isOnTrip == true {
//                if region.identifier == REGION_PICKUP {
//                    self.actionForButton = .startTrip
//                    self.actionBtn.setTitle(MSG_START_TRIP, for: .normal)
//                } else if region.identifier == REGION_DESTINATION {
//                    self.cancelBtn.fadeTo(alphaValue: 0.0, withDuration: 0.2)
//                    self.cancelBtn.isHidden = true
//                    self.actionForButton = .endTrip
//                    self.actionBtn.setTitle(MSG_END_TRIP, for: .normal)
//                }
//            }
//        })
//    }
//
//    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
//        DataService.instance.driverIsOnTrip(driverKey: currentUserId!, handler: { (isOnTrip, driverKey, tripKey) in
//            if isOnTrip == true {
//                if region.identifier == REGION_PICKUP {
//                    self.actionForButton = .getDirectionsToPassenger
//                    self.actionBtn.setTitle(MSG_GET_DIRECTIONS, for: .normal)
//                } else if region.identifier == REGION_DESTINATION {
//                    self.actionForButton = .getDirectionsToDestination
//                    self.actionBtn.setTitle(MSG_GET_DIRECTIONS, for: .normal)
//                }
//            }
//        })
//    }
//}
