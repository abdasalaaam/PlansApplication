//  MapViewController.swift
//  Plans2.0
//  Created by Alex Pallozzi on 3/24/22.

//  MapViewController.swift

//  Plans2.0

//  Created by Alex Pallozzi on 3/24/22.



import UIKit

import MapKit
class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    let activeUser : User = User.sampleUser;
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var eventListButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!

    

    @IBAction func unwindToMap(_ sender: UIStoryboardSegue) {
        // refresh map annotations
        mapView.delegate = self
        for annot in mapView.annotations {
            if annot.title == "YOU" {
            }
            else {
                mapView.removeAnnotation(annot)
            }
        }
        addMapOverlay(planList: activeUser.plans)
    }

    

    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad();
        backButton?.addTarget(self, action: #selector(backTap), for: .touchUpInside)
        // refresh annotations if needed
        mapView.delegate = self
        mapView.removeAnnotations(mapView.annotations)
        determineCurrentLocation();
        addMapOverlay(planList: activeUser.plans);

    }

    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationValue : CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let initialRegionSpan = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let initialRegion = MKCoordinateRegion(center: locationValue, span: initialRegionSpan)
        
        // display user's current location on the map
        mapView.setRegion(initialRegion, animated: false)

        // place an annotation/pin on the user's location in the map display
        let userLocationPin : MKPointAnnotation = MKPointAnnotation()
        userLocationPin.coordinate = CLLocationCoordinate2DMake(locationValue.latitude, locationValue.longitude)
        userLocationPin.title = "YOU"
        userLocationPin.subtitle = "this is you!"
        mapView.addAnnotation(userLocationPin)
        print("location = \(locationValue.latitude) \(locationValue.longitude)")

    }

    
    func addMapOverlay(planList : [Plan]) {
        for plan in planList {
            let planAnnotation : MKPointAnnotation = MKPointAnnotation()
               loc_coord(plan: plan) { (completion, error) in
                    if error == nil {
                    planAnnotation.coordinate = CLLocationCoordinate2DMake(completion.latitude, completion.longitude)
                    planAnnotation.title = plan.title
                    planAnnotation.subtitle = "\(Plan.dayText(plan.day))\n\(Plan.timeText(plan.startTime)) - \(Plan.timeText(plan.endTime))\n\(plan.address!)"
                    }
                    else {
                        print("error: improper coord")
                    }
               }
                mapView.addAnnotation(planAnnotation)
           }
    }

    

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "MyMarker")
        if annotation.title == "YOU" {
            annotationView.markerTintColor = .systemIndigo
            annotationView.glyphImage = UIImage(named: "bmoicon")
        }
        else if annotation.title != "YOU" {
            annotationView.markerTintColor = .systemOrange
            annotationView.glyphImage = UIImage(named: "connecticon")
        }
        else {
            annotationView.markerTintColor = .lightGray
            annotationView.glyphImage = UIImage(named: "connecticon")
        }
        return annotationView
    }



    // gets the coordinates of the address

    private func loc_coord(plan: Plan, completionHandler: @escaping (CLLocationCoordinate2D, NSError?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(plan.address) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
           }
       }

    

    func determineCurrentLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    

    @objc func backTap() {

        //set values for signup to null;

    }

}
