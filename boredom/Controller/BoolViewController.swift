//
//  BoolViewController.swift
//  boredom
//
//  Created by Yasin Ehsan on 7/9/19.
//  Copyright © 2019 Yasin Ehsan. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class BoolViewController: UIViewController {

    @IBOutlet weak var boolTableView: UITableView!
    var boolList: [Bools] = []
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        boolList = createBoolList()
        boolTableView.delegate = self
        boolTableView.dataSource = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func createBoolList() -> [Bools]{
        var tempBool: [Bools] = [Bools.bool1, Bools.bool2, Bools.bool3]
        return tempBool
    }
    
    @IBAction func createBool(segue:UIStoryboardSegue) {
        let addBoolVC = segue.source as! AddBoolViewController
        guard let destination: MKPlacemark = addBoolVC.boolLocation else { return }
        
        let newBool = Bools(suggester: "add bool meet at", time: destination.name ?? "", likes: 7)
        
        newBool.destination = destination
        
        boolList.append(newBool)
        boolTableView.reloadData()
    }

}

extension BoolViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            let span = UICoordinateSpace(latitudeDelta: 0.05, longitudeDelta: 0.05)
//            let region = KerxCoordinateAction(center: location.coordinate, span: span)
//            mapView.setRegion(region, animated: true)
//        }
    }
}

extension BoolViewController: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boolList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currCell = boolList[indexPath.row]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "boolCellID", for: indexPath) as? BoolTableViewCell else {
            print("dequeue cell didn't work")
            fatalError()
        }

        cell.setBool(bools: currCell)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //do this when tapped
    }
}
