//  MapViewController.swift
//  Plans2.0
//  Created by Alex Pallozzi on 3/24/22.

import UIKit
import MapKit
class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    let activeUser : User = User.sampleUser;
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var profileButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var eventListButton: UIButton!

    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func unwindToMap(_ sender: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
       super.viewDidLoad();
       //view.backgroundColor = .systemBlue;
       //profilePicture.frame = CGRect(x: 30, y: 150, width: 100, height: 100);
       backButton?.addTarget(self, action: #selector(backTap), for: .touchUpInside)
        determineCurrentLocation();
        addMapOverlay();
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           // get the current location of the user
           guard let locationValue : CLLocationCoordinate2D = manager.location?.coordinate else { return }
           let initialRegionSpan = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
           let initialRegion = MKCoordinateRegion(center: locationValue, span: initialRegionSpan)
           
           // display user's current location on the map
           mapView.setRegion(initialRegion, animated: true)
           
           // place an annotation/pin on the user's location in the map display
           let userLocationPin : MKPointAnnotation = MKPointAnnotation()
           userLocationPin.coordinate =
           CLLocationCoordinate2DMake(locationValue.latitude, locationValue.longitude)
           mapView.addAnnotation(userLocationPin)
           
           print("location = \(locationValue.latitude) \(locationValue.longitude)")
       }
    
    private func addMapOverlay() {
        for plan in activeUser.plans {
            let planAnnotation : MKPointAnnotation = MKPointAnnotation()
               loc_coord(plan: plan) { (completion, error) in
                   if error == nil {
                       planAnnotation.coordinate = CLLocationCoordinate2DMake(completion.latitude, completion.longitude)
                       print("plan location: \(planAnnotation.coordinate.latitude) \(planAnnotation.coordinate.longitude)")

                   }
                   else {
                       print("error: improper coord")
                   }
               }
               mapView.addAnnotation(planAnnotation)
           }
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}