//
//  ViewController.swift
//  Foursquare Clone Parse
//
//  Created by Mahmut Şenbek on 11.10.2022.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    @IBOutlet weak var emailOrUsernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Data saving at Parse
      /*
        let parseObject = PFObject(className: "Cars")
        parseObject["name"] = "Mercedes"
        parseObject["speed"] = "225"
        let parseObjectTwo = PFObject(className: "Price")
        parseObjectTwo["BMW"] = "250K$"
        
        parseObjectTwo.saveInBackground { success, error in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                print("uploaded2")
            }
        }
        
        parseObject.saveInBackground { success, error in
            
            if error != nil {
                
                print(error?.localizedDescription)
            }else {
                print("uploaded")
            }
        }
        */
        /*
        let query = PFQuery(className: "Cars")
       //query.whereKey("name", equalTo: "Mercedes")
        query.whereKey("speed", greaterThan: "226")
        query.findObjectsInBackground { objects, error in
            
            if error != nil {
                
                print(error?.localizedDescription)
            } else {
                
                print(objects)
            }
           
            
    }
         */
        
    }

    @IBAction func signUpClicked(_ sender: Any) {
        
        
        if emailOrUsernameTextField.text == "" && passwordTextField.text == "" {
            
           performSegue(withIdentifier: "signUpScreen", sender: nil)
            
        } else if emailOrUsernameTextField.text != "" || passwordTextField.text != "" {
            makeAlert(tittleInput: "No user founded.", messageInput: "Try to sign in.")
        }
        
    }
    
    
    
    
    @IBAction func signInClicked(_ sender: Any) {
        
        if emailOrUsernameTextField.text != "" && passwordTextField.text != "" {
            
            PFUser.logInWithUsername(inBackground: emailOrUsernameTextField.text!, password: passwordTextField.text!) { user, error in
                if error != nil {
                    self.makeAlert(tittleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else {
                    //print("Welcome")
                   // print(user?.email)
                    self.performSegue(withIdentifier: "placesVC", sender: nil)
                }
            }
            
            
        } else {
            makeAlert(tittleInput: "Error!", messageInput: "Please fill sections!")
        }
        
        
        
    }
    
    func makeAlert(tittleInput: String, messageInput: String) {
        
        let alert = UIAlertController(title: tittleInput, message: messageInput , preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    
}

}
