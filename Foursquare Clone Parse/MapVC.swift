//
//  MapVC.swift
//  Foursquare Clone Parse
//
//  Created by Mahmut Şenbek on 11.10.2022.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
var locationManager = CLLocationManager()
    
    var choosenLatitude = ""
    var choosenLongitude = ""
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesturePin = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gesturePin:)))
        gesturePin.minimumPressDuration = 1.5
        mapView.addGestureRecognizer(gesturePin)

        mapView.delegate = self
        locationManager.delegate = self
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.done, target: self, action: #selector(saveButtonMap))
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    @objc func chooseLocation(gesturePin:UILongPressGestureRecognizer){
        
        if gesturePin.state == .began {
            
            let touchedPoint = gesturePin.location(in: self.mapView)
            let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinates
            annotation.title = PlaceModel.sharedInstance.placeName
            annotation.subtitle = PlaceModel.sharedInstance.placeType
            self.mapView.addAnnotation(annotation)
            
            self.choosenLatitude = String(touchedCoordinates.latitude)
            self.choosenLatitude = String(touchedCoordinates.longitude)
        }
    }
    
    @objc func saveButtonMap() {
      
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.006, longitudeDelta: 0.006)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
  

}
