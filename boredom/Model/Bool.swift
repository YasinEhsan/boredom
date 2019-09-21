//
//  Bool.swift
//  boredom
//
//  Created by Yasin Ehsan on 7/9/19.
//  Copyright © 2019 Yasin Ehsan. All rights reserved.
//

import Foundation
import MapKit

class Bools {
    
    let suggester: String
    let time: String
//    let mapView: MKMapView
    let likes: Int
    
    init(suggester: String, time: String, likes: Int) {
        self.suggester = suggester
        self.time = time
//        self.mapView = mapView
        self.likes = likes
    }
}

//dummy varaibles
extension Bools {
    static let bool1 = Bools(suggester: "Yasin", time: "7:30", likes: 7)
    static let bool2 = Bools(suggester: "Zukl", time: "4:30", likes: 10)
    static let bool3 = Bools(suggester: "Becky", time: "12:30", likes: 2)
}
