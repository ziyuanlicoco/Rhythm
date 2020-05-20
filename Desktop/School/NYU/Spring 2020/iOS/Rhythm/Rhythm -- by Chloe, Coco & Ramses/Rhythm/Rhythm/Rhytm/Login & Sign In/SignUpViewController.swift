//
//  SignUpViewController.swift
//  Rhytm
//
//  Created by Ramses Sanchez Hernandez on 4/29/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth





class SignUpViewController: UIViewController, UITextFieldDelegate{

    //Labels and textfields
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    @IBOutlet weak var errorMessage: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessage.isHidden = true
        // Do any additional setup after loading the view.
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "info-page.png")!)
    }
    
    //Hide keyboard when user taps 'return' on keyboard
    func textFieldShouldReturn(_textField: UITextField) -> Bool
    {
        _textField.resignFirstResponder();

    }
    
    //Hide keyboard when user taps outside the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Ensure form is filled in correctly
    //Else return false
    func checkFields() -> Bool
    {
        //Ensure all fields filled out
        if(firstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "")
        {
            callError(errorText: "One or more fields have been left empty")
            return false
        }

        //Calls isValidPassword to make sure it is a Strong password
        if(isValidPassword(password: password.text!) == false)
        {
            callError(errorText: "Password must include at least one number, a special character ($@$#!%?&), and an uppercase letter.")
            return false
        }
        
        //Make sure the two password text fields match
        if(confirmPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) != password.text?.trimmingCharacters(in: .whitespacesAndNewlines))
        {
            callError(errorText: "Passwords do not match")
            return false
        }
        
        return true
    }

    
    //Handle functionality when user taps the signUp button
    @IBAction func signUp(_ sender: Any)
    {
        
        if checkFields()
        {
            //If all fields are filled trim white spaces and new line characters from all text fields
            let fName = firstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lName = lastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let em = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let pword =  password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create a new User object to pass into firestore
            let newUser = User(fName: fName, lName: lName, eMail: em)
            
            //Try to reach firebase and create a new user with email and password
            //If an issue occurs connecting to firebase display the error
            //Else create a new user with the info from the User object created above
            Auth.auth().createUser(withEmail: em, password: pword) { (result, error) in
                if error != nil
                {
                    self.callError(errorText: error!.localizedDescription)
                }
                else
                {
                    let db = Firestore.firestore()
                    do{
                        try _ = db.collection("users").document(result!.user.uid).setData(from: newUser)
                    } catch{
                        print("Unable to add new user to firestore")
                    }
                    //If all else successful, transition to the home screen
                    self.transitionToHomeScreen()
                }
            }
        }
    }
    
    //Handle displaying error
    //errorText: A string containing the error message to display
    func callError(errorText: String)
    {
        errorMessage.isHidden = false
        errorMessage.text = errorText
    }
    
    //Handle the transition to the 'Main' storyboard, specifically the 'homeVC' view controller
    func transitionToHomeScreen()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "homeVC") as UIViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    
    //Returns true if the password passed meets security requirments
    //password: password to check
    func isValidPassword(password: String) -> Bool
    {
        //Password requires 1 uppercase, 1 lowercase, one special char, one number, length 8
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z])(?=.*[$@$#!%*?&])(?=.*[0-9])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
        
    }
}

