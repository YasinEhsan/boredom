//
//  ContactTableViewCell.swift
//  boredom
//
//  Created by Yasin Ehsan on 7/6/19.
//  Copyright © 2019 Yasin Ehsan. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    func setContact(contact: Contact) {
        var isBoredText = "No account"
        if let isBored = contact.isBored
        {
            isBoredText = isBored ? "Bored" : "Busy"
        }
        nameLabel.text = contact.firstName + " " + contact.number + " " + isBoredText
        numberLabel.text = contact.number
        //add family name for later
    }
}
