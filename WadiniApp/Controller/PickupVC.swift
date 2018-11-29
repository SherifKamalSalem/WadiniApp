//
//  PickupVC.swift
//  WadiniApp
//
//  Created by Sherif Kamal on 10/19/18.
//  Copyright © 2018 Sherif Kamal. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class PickupVC: UIViewController {
    
    @IBOutlet weak var pickupMapView: RoundMapView!
    @IBOutlet weak var pickupLocationLbl: UILabel!
    @IBOutlet weak var pickupDistanceLbl: UILabel!
    @IBOutlet weak var tripFareLbl: UILabel!
    @IBOutlet weak var passengerNameLbl: UILabel!
    
    var pickupCoordinate: CLLocationCoordinate2D!
    var destinationCoordinate: CLLocationCoordinate2D!
    var driverCoordinate: CLLocationCoordinate2D!
    
    var passengerKey: String!
    var passengerName: String?
    
    var regionRadius: CLLocationDistance = 2000
    var pin: MKPlacemark? = nil
    
    var locationPlacemark: MKPlacemark!
    
    var currentUserId = Auth.auth().currentUser?.uid
    
    func getDir() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickupMapView.delegate = self
        
        locationPlacemark = MKPlacemark(coordinate: pickupCoordinate)
        
        dropPinFor(placemark: locationPlacemark)
        centerMapOnLocation(location: locationPlacemark.location!)
        
        fetchPickupAddress()
        setupTripInfo()
        
        DataService.instance.REF_TRIPS.child(passengerKey).observe(.value, with: { (tripSnapshot) in
            if tripSnapshot.exists() {
                if tripSnapshot.childSnapshot(forPath: TRIP_IS_ACCEPTED).value as? Bool == true {
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    func initData(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D, tripKey: String) {
        self.pickupCoordinate = pickupCoordinate
        self.destinationCoordinate = destinationCoordinate
        self.passengerKey = tripKey
    }
    
    private func fetchPickupAddress(){
        let location = CLLocation(latitude: pickupCoordinate!.latitude, longitude: pickupCoordinate!.longitude)
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if error != nil {
                print(error!)
                return
            }
            guard let placemark = placemarks?.first else { return }
            let address = "\(placemark.subThoroughfare!) \(placemark.thoroughfare!), \(placemark.locality!) \(placemark.administrativeArea!), \(placemark.country!)"
            self.pickupLocationLbl.text = address
        }
    }
    
    private func setupTripInfo(){
        
        let destinationLocation = CLLocation(latitude: destinationCoordinate!.latitude, longitude: destinationCoordinate!.longitude)
        let pickupLocation = CLLocation(latitude: pickupCoordinate!.latitude, longitude: pickupCoordinate!.longitude)
        let driverLocation = CLLocation(latitude: driverCoordinate!.latitude, longitude: driverCoordinate!.longitude)
        let tripDistance = pickupLocation.distance(from: destinationLocation) / 1000
        let pickupDistance = pickupLocation.distance(from: driverLocation) / 1000

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil))
        
        request.transportType = .automobile
        let directions = MKDirections(request: request)
        directions.calculateETA { response, error -> Void in
            guard response != nil else { return }
            if let err = error {
                print("error: \(err.localizedDescription)")
                return
            }
            let tripFare = DataService.instance.getTripFareEstimate(distance: Double(response!.distance), time: Double(response!.expectedTravelTime))
            print("trip fare: \(tripFare)")
            self.tripFareLbl.text = String(format: "%.2f", tripFare) + " $"
            self.pickupDistanceLbl.text = String(format: "%.2f", response!.distance / 1000) + " km"
        }
        passengerNameLbl.text = passengerName ?? "Sherif"
    }
    
    @IBAction func acceptTripBtnWasPressed(_ sender: Any) {
        UpdateService.instance.acceptTrip(withPassengerKey: passengerKey, forDriverKey: currentUserId!)
        presentingViewController?.shouldPresentLoadingView(true)
    }
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension PickupVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pickupPoint"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "destinationAnnotation")
        
        return annotationView
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        pickupMapView.setRegion(coordinateRegion, animated: true)
    }
    
    func dropPinFor(placemark: MKPlacemark) {
        pin = placemark
        
        for annotation in pickupMapView.annotations {
            pickupMapView.removeAnnotation(annotation)
        }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        
        pickupMapView.addAnnotation(annotation)
    }
}
