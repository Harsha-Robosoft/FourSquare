//
//  HomePageViewController.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 03/01/23.
//

import UIKit
import CoreLocation
import MapKit

class HomePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    var index = 0
    var manager = CLLocationManager()
    
    @IBOutlet weak var mapIs: MKMapView!
    @IBOutlet weak var mapHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView01: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView01.delegate = self
        tableView01.dataSource = self
   
        tableView01.register(UINib(nibName: "mapFile", bundle: nil), forCellReuseIdentifier: "cell")
    }
 

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        print(index)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
             print("error:: \(error.localizedDescription)")
        }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            print("Current location: \(location)")
            manager.stopUpdatingLocation()
            
            render(location: location)
        }
    }
    
    
    func render(location: CLLocation) {
        
        
        let coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapIs.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapIs.addAnnotation(pin)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if index == 0 {
            mapHeight.constant = 150
        }else{
            mapHeight.constant = 0
        }
        
        let cell = tableView01.dequeueReusableCell(withIdentifier: "cell") as! HomeTableViewCell
        cell.imageIs.image = #imageLiteral(resourceName: "Ferrari-1200-1-1024x683")
        cell.addresIs.text = "kjhyutyrsaetzfxghcvkgfydtuxcgvhgui"
        cell.distanceIs.text = "9.0km"
        cell.nameIs.text = "Attil"
        cell.rateIs.text = "₹₹₹₹"
        cell.nationalityIs.text = "indian"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
}
