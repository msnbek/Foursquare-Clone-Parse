//
//  signUpScreen.swift
//  Foursquare Clone Parse
//
//  Created by Mahmut Şenbek on 11.10.2022.
//

import UIKit
import Parse

class signUpScreen: UIViewController {
    @IBOutlet weak var eMailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if  eMailTextField.text != "" && usernameTextField.text != "" && passwordTextField.text != "" {
            
            let user = PFUser()
            
            user.username = usernameTextField.text!
            user.password = passwordTextField.text!
            user.email = eMailTextField.text!
            user.signUpInBackground { success, error in
                if error != nil {
                    
                    self.makeAlert(tittleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                    
                }
                self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                //print("Created.")
                
            }
            
            
            
        } else {
            makeAlert(tittleInput: "Error", messageInput: "Fill sections.")
        }
        
        
    }
    func makeAlert(tittleInput: String, messageInput: String) {
        
        let alert = UIAlertController(title: tittleInput, message: messageInput , preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    
}

}
