//
//  EntryViewController.swift
//  boredom
//
//  Created by Yasin Ehsan on 7/5/19.
//  Copyright © 2019 Yasin Ehsan. All rights reserved.
//

import UIKit
import FirebaseAuth

class EntryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        //FOR DEV ONLY: sign out if app is deleted out of app
        if UserDefaults.standard.value(forKey: "authVerificationID") == nil
        {
            do { try Auth.auth().signOut() } catch { }
        }
        
        Auth.auth().addStateDidChangeListener({ auth, user in
            if user != nil
            {
                let boredViewCont = storyBoard.instantiateViewController(withIdentifier: "boredViewCont") as! BoredViewController
                self.present(boredViewCont, animated: false, completion: nil)
            }
            else
            {
                let loginViewCont = storyBoard.instantiateViewController(withIdentifier: "loginViewCont") as! LoginViewController
                self.present(loginViewCont, animated: false, completion: nil)
            }
        })
    }
    

}
