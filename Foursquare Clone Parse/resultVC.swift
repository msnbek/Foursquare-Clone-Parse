//
//  resultVC.swift
//  Foursquare Clone Parse
//
//  Created by Mahmut Şenbek on 11.10.2022.
//

import UIKit
import MapKit
import Parse

class resultVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var placeCommentLabel: UILabel!
    @IBOutlet weak var placeTypeLabel: UILabel!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var choosenId = ""
    var choosenLatitude = Double()
    var choosenLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getDataFromParse()
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.done, target: self, action: #selector(backButton))
       
    
    }
    
    @objc func backButton() {
        
        performSegue(withIdentifier: "toTableView", sender: self)
    }
    
    func getDataFromParse() {
        
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: choosenId)
        query.findObjectsInBackground { objects, error in
            if error != nil {
                
                self.makeAlert(tittleInput: "error", messageInput: error?.localizedDescription ?? "Error")
            } else {
                
                if objects != nil {
                    if objects!.count > 0 {
                        let choosenPlaceObject = objects![0]
                        
                        if let placeName = choosenPlaceObject.object(forKey: "name") as? String {
                            self.placeNameLabel.text = placeName
                        }
                        if let placeComment = choosenPlaceObject.object(forKey: "comment") as? String {
                            self.placeCommentLabel.text = placeComment
                        }
                        if let placeType = choosenPlaceObject.object(forKey: "type") as? String {
                            self.placeTypeLabel.text = placeType
                        }
                        if let placeLatitude = choosenPlaceObject.object(forKey: "latitude") as? String {
                            if let placeLatitudeDouble = Double(placeLatitude) {
                                self.choosenLatitude = placeLatitudeDouble
                            }
                        }
                        
                        if let placeLongitude = choosenPlaceObject.object(forKey: "longitude") as? String {
                            if let placeLongitudeDouble = Double(placeLongitude) {
                                self.choosenLongitude = placeLongitudeDouble
                            }
                        }
                       if let imageData = choosenPlaceObject.object(forKey: "image") as? PFFileObject {
                           imageData.getDataInBackground { data, error in
                               if error != nil {
                                   
                                   //alert
                                   
                               }else {
                                   if data != nil {
                                       self.imageView.image = UIImage(data: data!)
                                   }
              
                               }
                           }
                        }
                        
                        let location = CLLocationCoordinate2D(latitude: self.choosenLatitude, longitude: self.choosenLongitude)
                        
                        let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
                        
                        let region = MKCoordinateRegion(center: location, span: span)
                        
                        self.mapView.setRegion(region, animated: true)
                        
                        
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = location
                        annotation.title = self.placeNameLabel.text!
                        annotation.subtitle = self.placeCommentLabel.text!
                        self.mapView.addAnnotation(annotation)
                        
                        }
                   
                }
                
            }
        }
    }
  
    func makeAlert(tittleInput: String, messageInput: String) {
        
        let alert = UIAlertController(title: tittleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: tittleInput, style: UIAlertAction.Style.default, handler: nil)
        self.present(alert, animated: true)
        alert.addAction(okButton)
        
    }
}
