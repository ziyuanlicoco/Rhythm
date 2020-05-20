//
//  EditUserInfoViewController.swift
//  Rhytm
//
//  Created by Ramses Sanchez Hernandez on 5/10/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore

//Add protocol to update the User object stored in the app
protocol editUserDelegate
{
    func updateUser(user: User)
}


class EditUserInfoViewController: UIViewController {
    
    //Labels and textfields
    @IBOutlet weak var currentValLabel: UILabel!
    @IBOutlet weak var newValTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    weak var delegate: UserProfileViewController?
    
    var currentUser: User!
    //Tag is used to identify what the user wants to update
    var tag: Int!
    
    //User ID to access the users info on firebase
    let userID = Auth.auth().currentUser!.uid
    let db = Firestore.firestore()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        
        
        //Display the titles to match the desired edit field
        //1: Editing first name
        //2: Editing last name
        //3: Editing email
        switch tag {
        case 1:
            currentValLabel.text = currentUser.firstName
            titleLabel.text = "Edit First Name"
            newValTextField.placeholder = "New First Name"
        case 2:
            currentValLabel.text = currentUser.lastName
            titleLabel.text = "Edit Last Name"
            newValTextField.placeholder = "New Last Name"
        case 3:
            currentValLabel.text = currentUser.email
            titleLabel.text = "Edit Email"
            newValTextField.placeholder = "New Email"
        default:
            currentValLabel.text = "Error"
            titleLabel.text = "Error"
            newValTextField.placeholder = "Error"
        }
        // Do any additional setup after loading the view.
    }
    
    //Save the info if user selects save info button
    @IBAction func SaveNewInfo(_ sender: Any) {
        let newVal = newValTextField.text
        switch tag {
        case 1:
            updateSimple(newValue: newVal!)
            dismiss(animated: true, completion: nil)
        case 2:
            updateSimple(newValue: newVal!)
            dismiss(animated: true, completion: nil)
        case 3:
            updateEmail(newEmail: newVal!)
        default:
            print("Error")
        }   
    }
    
    //Special function needed to update the email in the auth database
    //Calls updateSimple iff successful in updating credentials in the auth database
    func updateEmail(newEmail: String)
    {
        Auth.auth().currentUser?.updateEmail(to: newEmail, completion: { (error) in
            if let error = error
            {
                self.callError(errorText: error.localizedDescription)
            }
            else{
                self.updateSimple(newValue: newEmail)
                self.dismiss(animated: true, completion: nil)
                print("email Changed")
            }
        })
    }
    
    //Update the desired value in the firestore cloud databse
    //Updates the name, email, or first name
    //Does not affect the auth database which is seperate
    func updateSimple(newValue: String)
    {
        var fieldName: String!
        switch tag {
        case 1:
            fieldName = "firstName"
            currentUser.firstName = newValue
        case 2:
            fieldName = "lastName"
            currentUser.lastName = newValue
        case 3:
            fieldName = "email"
            currentUser.email = newValue
        default:
            fieldName = "error"
        }
        
        //Update the user object stored locally in the app
        self.delegate?.updateUser(user: currentUser)
        
        let ref = db.collection("users").document(userID)
        ref.updateData([fieldName : newValue]) { (err) in
            if let err = err
            {
                self.callError(errorText: err.localizedDescription)
            }
        }
        
    }
    
    
    //Hide keyboard when user taps outside the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Hide keyboard when user taps 'return' on keyboard
    func textFieldShouldReturn(_textField: UITextField) -> Bool
    {
        _textField.resignFirstResponder();

    }
    
    //Display error label and text
    //errorText: error string to display
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
