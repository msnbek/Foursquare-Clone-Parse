//
//  PlacesVC.swift
//  Foursquare Clone Parse
//
//  Created by Mahmut Şenbek on 11.10.2022.
//

import UIKit
import Parse

class PlacesVC: UIViewController,UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var placeNameArray = [String]()
    var placeIdArray = [String]()
    var selectedId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButton))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.done, target: self, action: #selector(logoutButton))
        
        getDataFromPlace()
    }
    
    
    func getDataFromPlace() {
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground { objects, error in
            if error != nil {
                self.makeAlert(tittleInput: "Error", messageInput: error?.localizedDescription ?? "error")
            } else {
                if objects != nil {
                    
                    self.placeIdArray.removeAll(keepingCapacity: false)
                    self.placeNameArray.removeAll(keepingCapacity: false)
                    
                    for object in objects! {
                        	
                     if let placeName = object.object(forKey: "name") as? String {
                         if let placeID = object.objectId {
                             self.placeNameArray.append(placeName)
                             self.placeIdArray.append(placeID)
                             
                         }
                            
                        }
                    }
                    
                    self.tableView.reloadData()
                }
               
                
            }
        }
        
        
    }
    
    @objc func logoutButton() {
        
        PFUser.logOutInBackground { error in
            if error != nil {
                self.makeAlert(tittleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                
            } else {
                self.performSegue(withIdentifier: "logoutVC", sender: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placeNameArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeNameArray.count
    }
    
    @objc func addButton() {
        
        performSegue(withIdentifier: "toMapVC", sender: nil)
    }
    
    func makeAlert(tittleInput: String, messageInput: String) {
        
        let alert = UIAlertController(title: tittleInput, message: messageInput , preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    
}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedId = placeIdArray[indexPath.row]
        performSegue(withIdentifier: "toResultVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResultVC" {
            let destinationVC = segue.destination as! resultVC
            destinationVC.choosenId = selectedId
        }
    
    
    
    
    
    
    
    }
    
    



   

}
