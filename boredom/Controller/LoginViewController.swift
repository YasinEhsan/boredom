//
//  LoginViewController.swift
//  boredom
//
//  Created by Yasin Ehsan on 7/5/19.
//  Copyright © 2019 Yasin Ehsan. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet var phoneField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func enterPressed() {
        let alert = UIAlertController(title: "SMS Login", message: "Message & data rates may apply", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            if let phoneNumber = self.phoneField.text
            {
                PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil, completion: self.verifyPhoneHandler(verificationID:error:))
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func verifyPhoneHandler(verificationID: String?, error: Error?) {
        if let error = error {
            displayError(error: error)
            return
        }
        UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
        
        let alert = UIAlertController(title: "Verify", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { textfield in
            textfield.placeholder = "Enter the code that was texted to you"
        })
        alert.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: { [weak alert] action in
            let textField = alert!.textFields![0]
            if let code = textField.text
            {
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!, verificationCode: code)
//                Auth.auth().signIn(with: credential, completion: self.signInHandler(user:error:))
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func signInHandler(user: User?, error: Error?) {
        if let error = error {
            displayError(error: error)
            return
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let boredViewCont = storyBoard.instantiateViewController(withIdentifier: "boredViewCont") as! BoredViewController
        self.present(boredViewCont, animated: true, completion: nil)
    }
    
    func displayError(error: Error)
    {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
