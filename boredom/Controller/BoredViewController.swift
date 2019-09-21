//
//  BoredViewController.swift
//  boredom
//
//  Created by Yasin Ehsan on 7/5/19.
//  Copyright © 2019 Yasin Ehsan. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import UserNotifications

class BoredViewController: UIViewController {
  
    @IBOutlet var boredButton: UIButton!
    var isBored = false
    var uid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //firebase setup
        let db = Firestore.firestore()
        Auth.auth().addStateDidChangeListener({ auth, user in
            if let user = user
            {
                self.uid = user.uid
                
                let docRef = db.collection("users").document(user.uid)
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
//                        self.setBored(isBored: document.data()["isBored"] as! Bool)
                        return
                    }
                    self.setBored(isBored: self.isBored)
                    self.setUsersEntry(uid: user.uid, phoneNumber: user.phoneNumber!, isBored: self.isBored)
                }
            }
        })
        
        //notifications setup
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in } //bootstrapped odee
    }
    
    func setBored(isBored: Bool) {
        self.isBored = isBored
        boredButton.setTitle(isBored ? "Status: bored" : "Status: not bored", for: .normal)
    }
    
    func setUsersEntry(uid: String, phoneNumber: String, isBored: Bool = false) {
        let db = Firestore.firestore()
        db.collection("users").document(uid).setData([
            "isBored": isBored,
            "phoneNumber": phoneNumber
        ]) { err in
            if let err = err {
                print("Error setUsersEntry: \(err)")
            }
        }
    }
    
    func updateBoredEntry(uid: String, isBored: Bool) {
        let db = Firestore.firestore()
        db.collection("users").document(uid).updateData([
            "isBored": isBored
        ]) { err in
            if let err = err {
                print("Error updateBoredEntry: \(err)")
            }
        }
    }
    
    @IBAction func boredButtonPressed(_ sender: Any) {
        self.setBored(isBored: !isBored)
        updateBoredEntry(uid: self.uid, isBored: isBored)
    }
    
    
    
    //MARK: - notifications and alert
    func showAlert(_ title: String, _ message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func showNotifications(_ title: String, _ message: String){
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.badge = 2 //the red notification icon
        content.sound = .default
        
        let request = UNNotificationRequest(identifier: "noti", content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    

}
