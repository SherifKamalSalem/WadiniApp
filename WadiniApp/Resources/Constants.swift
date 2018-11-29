//
//  Constants.swift
//  WadiniApp
//
//  Created by Sherif Kamal on 10/22/18.
//  Copyright © 2018 Sherif Kamal. All rights reserved.
//

import Foundation

// Account
let ACCOUNT_IS_DRIVER = "isDriver"
let ACCOUNT_PICKUP_MODE_ENABLED = "isPickupModeEnabled"
let ACCOUNT_TYPE_PASSENGER = "PASSENGER"
let ACCOUNT_TYPE_DRIVER = "DRIVER"

// Location
let COORDINATE = "coordinate"
let GOOGlE_API_KEY = "AIzaSyDAP3QGi-WNe31FU2QqcvzayuK3tvkO3Jw"

// Trip
let TRIP_COORDINATE = "tripCoordinate"
let TRIP_IS_ACCEPTED = "tripIsAccepted"
let TRIP_IN_PROGRESS = "tripIsInProgress"
let BASE_FARE = 2.55
let TIME_RATE = 0.35
let DISTANCE_RATE = 1.75

// User
let USER_PICKUP_COORDINATE = "pickupCoordinate"
let USER_DESTINATION_COORDINATE = "destinationCoordinate"
let USER_PASSENGER_KEY = "passengerKey"
let USER_IS_DRIVER = "userIsDriver"

// Driver
let DRIVER_KEY = "driverKey"
let DRIVER_IS_ON_TRIP = "driverIsOnTrip"

// Map Annotations
let ANNO_DRIVER = "driverAnnotation"
let ANNO_PICKUP = "currentLocationAnnotation"
let ANNO_DESTINATION = "destinationAnnotation"

// Map Regions
let REGION_PICKUP = "pickup"
let REGION_DESTINATION = "destination"

// Storyboard
let MAIN_STORYBOARD = "Main"

// ViewControllers
let VC_LEFT_PANEL = "LeftSidePanelVC"
let VC_HOME = "HomeVC"
let VC_LOGIN = "LoginVC"
let VC_PICKUP = "PickupVC"

// TableViewCells
let CELL_LOCATION = "locationCell"

// UI Messaging
let MSG_SIGN_UP_SIGN_IN = "Sign Up / Login"
let MSG_SIGN_OUT = "Sign Out"
let MSG_PICKUP_MODE_ENABLED = "PICKUP MODE ENABLED"
let MSG_PICKUP_MODE_DISABLED = "PICKUP MODE DISABLED"
let MSG_REQUEST_RIDE = "REQUEST RIDE"
let MSG_START_TRIP = "START TRIP"
let MSG_END_TRIP = "END TRIP"
let MSG_GET_DIRECTIONS = "GET DIRECTIONS"
let MSG_CANCEL_TRIP = "CANCEL TRIP"
let MSG_DRIVER_COMING = "DRIVER COMING"
let MSG_ON_TRIP = "ON TRIP"
let MSG_PASSENGER_PICKUP = "Passenger Pickup Point"
let MSG_PASSENGER_DESTINATION = "Passenger Destination"

// Error Messages
let ERROR_MSG_NO_MATCHES_FOUND = "No matches found. Please try again!"
let ERROR_MSG_INVALID_EMAIL = "Sorry, the email you've entered appears to be invalid. Please try another email."
let ERROR_MSG_EMAIL_ALREADY_IN_USE = "It appears that email is already in use by another user. Please try again."
let ERROR_MSG_WRONG_PASSWORD = "The password you tried is incorrect. Please try again."
let ERROR_MSG_UNEXPECTED_ERROR = "There has been an unexpected error. Please try again."
