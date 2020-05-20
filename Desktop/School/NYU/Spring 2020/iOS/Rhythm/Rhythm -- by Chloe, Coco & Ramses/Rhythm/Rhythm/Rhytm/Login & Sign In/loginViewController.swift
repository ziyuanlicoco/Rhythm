//
//  loginViewController.swift
//  Rhytm
//
//  Created by Ramses Sanchez Hernandez on 4/18/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class loginViewController: UIViewController, UITextFieldDelegate{

    
    //Componenets from storyboard
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Simple page setup, hide error label
        errorLabel.isHidden = true
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "info-page.png")!)
        // Do any additional setup after loading the view.
    }
    
    //Hide the keyboard when the user taps outside the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
       }
    
    //Hide the keyboard when return is pressed
    func textFieldShouldReturn(_textField: UITextField) -> Bool
    {
        _textField.resignFirstResponder();

    }

    
    //Check the fields and ensure the user has entered an email and password
    func checkFields() -> Bool
    {
        if(email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "")
        {
            callError(errorText: "One or more fields have been left empty")
            return false
        }
        
        return true
    }
    
    
    //Manages actions when login button is pressed
    @IBAction func loginPressed(_ sender: Any)
    {
        if checkFields()
        {
            //Remove spaces and new line characters from the email and password textfields
            let em = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let pword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //If error while authenticating, display error
            //Else transition to home screen
            Auth.auth().signIn(withEmail: em, password: pword) { (result, error) in
                if error != nil
                {
                    self.callError(errorText: "Incorrect Email or Password")
                }
                else
                {
                    self.transitionToHomeScreen()
                }
            }
        }
        
        
    }
    
    //Handle the transition to the 'Main' storyboard, specifically the 'homeVC' view controller
    func transitionToHomeScreen()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "homeVC") as UIViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    //Handle displaying error
    //errorText: A string containing the error message to display
    func callError(errorText: String)
    {
        errorLabel.isHidden = false
        errorLabel.text = errorText
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
