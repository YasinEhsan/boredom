//
//  ContactListing.swift
//  boredom
//
//  Created by Yasin Ehsan on 7/5/19.
//  Copyright © 2019 Yasin Ehsan. All rights reserved.
//

import Foundation
import Contacts
import FirebaseFirestore
import PhoneNumberKit

class Contact {
    
    let firstName: String
    let familyName: String
    let number: String
    var isFavorite = false
    var isBored: Bool?
    var uid: String?
    weak var delegate: ContactDelegate?
    
    init(firstName: String, familyName: String, number: String) {
        self.firstName = firstName
        self.familyName = familyName
        
        do {
            let phoneNumberKit = PhoneNumberKit()
            let numberObject = try phoneNumberKit.parse(number)
            self.number = phoneNumberKit.format(numberObject, toType: .e164)
        } catch {
            print("Generic parser error")
            self.number = number
        }
        
        self.isBored = nil
        self.uid = nil
        grabFirestoreDataAndSetupListener()
    }
    
    func grabFirestoreDataAndSetupListener() {
        let db = Firestore.firestore()
        let usersRef = db.collection("users")
        usersRef.whereField("phoneNumber", isEqualTo: number).getDocuments { (snapshot, error) in
            if snapshot?.documents.count ?? 0 > 0, let document = snapshot?.documents[0] {
                self.uid = document.documentID
                self.grabBoredAndSetupListener(uid: self.uid!)
            }
        }
    }
    
    func grabBoredAndSetupListener(uid: String) {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(uid)
        docRef.addSnapshotListener { (snapshot, error) in
            if let document = snapshot, document.exists {
                self.isBored = document.data()?["isBored"] as? Bool
                self.delegate?.didFinishUpdates()
            }
        }
    }
}

protocol ContactDelegate: class {
    func didFinishUpdates()
}
