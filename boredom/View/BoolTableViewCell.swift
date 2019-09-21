//
//  BoolTableViewCell.swift
//  boredom
//
//  Created by Yasin Ehsan on 7/9/19.
//  Copyright © 2019 Yasin Ehsan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class BoolTableViewCell: UITableViewCell {

    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var likesLabel: UILabel!
    
    func setBool(bools: Bools){
        headlineLabel.text = String(format: "%@ by %@", bools.time, bools.suggester)
        likesLabel.text = String(bools.likes)
        
        guard let destination: MKPlacemark = bools.destination else {return}
        dropPinZoomIn(placemark: destination)
    }
    
    
    
    func dropPinZoomIn(placemark:MKPlacemark){
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "(city) (state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
   

}
