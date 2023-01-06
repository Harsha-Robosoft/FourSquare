//
//  HomePageViewController.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 03/01/23.
//

import UIKit
import CoreLocation
import MapKit

protocol sendingIndex {
    func gotoIndex(index: Int)
}

class HomePageVc: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    var objectOfHomeViewModel = HomeViewModel.objectOfViewModel

    
    
    var index = 0
    var manager = CLLocationManager()
    
    @IBOutlet weak var mapIs: MKMapView!
    @IBOutlet weak var mapHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView01: UITableView!
    
    var delegate2: sendingIndex?
    
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
        delegate2?.gotoIndex(index: index)
        print("index is  : ",index)
        checkInedxForApicall(index: index)
    }
    
    func checkInedxForApicall(index: Int) {
        
//        let latitude = "13.379162"
//        let longitude = "74.740373"
        
//        tableViewHeight.constant = 0
        
        if index == 0{
            let loader =   self.loader()
            objectOfHomeViewModel.apiCallForData(endPoint: "/getNearPlace", latToSend: String(objectOfHomeViewModel.userLocation.last?.latitude ?? "13.379162"), longToSend: String(objectOfHomeViewModel.userLocation.last?.longitude ?? "74.740373")){ status in
                DispatchQueue.main.async() {
                    self.stopLoader(loader: loader)
                if status == true{
                    
                    self.tableView01.reloadData()
                }else{
                    self.tableView01.isHidden = true
                }
                }
            }
        }else if index == 1{
            let loader =   self.loader()
            objectOfHomeViewModel.apiCallForData(endPoint: "/getTopPlace", latToSend: String(objectOfHomeViewModel.userLocation.last?.latitude ?? "13.379162"), longToSend: String(objectOfHomeViewModel.userLocation.last?.longitude ?? "74.740373")){ status in
                DispatchQueue.main.async() {
                    self.stopLoader(loader: loader)
                    if status == true{
                        self.tableView01.isHidden = false
                        self.tableView01.reloadData()
                    }else{
                        self.tableView01.isHidden = true
                    }
                }
            }
        }else if index == 2{
            let loader =   self.loader()
            objectOfHomeViewModel.apiCallForData(endPoint: "/getPopularPlace", latToSend: String(objectOfHomeViewModel.userLocation.last?.latitude ?? "13.379162"), longToSend: String(objectOfHomeViewModel.userLocation.last?.longitude ?? "74.740373")){ status in
                DispatchQueue.main.async() {
                    self.stopLoader(loader: loader)
                    if status == true{
                        self.tableView01.isHidden = false
                        self.tableView01.reloadData()
                    }else{
                        self.tableView01.isHidden = true
                    }
                }
            }
        }else if index == 3{
            let loader =   self.loader()
            objectOfHomeViewModel.apiCallForData(endPoint: "/getRestaurants", latToSend: String(objectOfHomeViewModel.userLocation.last?.latitude ?? "13.379162"), longToSend: String(objectOfHomeViewModel.userLocation.last?.longitude ?? "74.740373")){ status in
                DispatchQueue.main.async() {
                    self.stopLoader(loader: loader)
                    if status == true{
                        self.tableView01.isHidden = false
                        self.tableView01.reloadData()
                    }else{
                        self.tableView01.isHidden = true
                    }
                }
            }
        }else if index == 4{
            let loader =   self.loader()
            objectOfHomeViewModel.apiCallForData(endPoint: "/getCafe", latToSend: String(objectOfHomeViewModel.userLocation.last?.latitude ?? "13.379162"), longToSend: String(objectOfHomeViewModel.userLocation.last?.longitude ?? "74.740373")){ status in
                DispatchQueue.main.async() {
                    self.stopLoader(loader: loader)
                    if status == true{
                        self.tableView01.isHidden = false
                        self.tableView01.reloadData()
                    }else{
                        self.tableView01.isHidden = true
                    }
                }
            }
        }else{
            
        }
        
        
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
            objectOfHomeViewModel.updateUserLocation(lat: String(location.coordinate.latitude), long: String(location.coordinate.longitude))
//            print("Current location: \(location)")
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
        if objectOfHomeViewModel.homeDetails.count != 0{
            return objectOfHomeViewModel.homeDetails.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if index == 0 {
            mapHeight.constant = 150
        }else{
            mapHeight.constant = 0
        }
        
        let cell = tableView01.dequeueReusableCell(withIdentifier: "cell") as! HomeTableViewCell
        
        if objectOfHomeViewModel.homeDetails[indexPath.row].placeImage != nil {
            
            var imageIs = objectOfHomeViewModel.homeDetails[indexPath.row].placeImage
            
            imageIs.insert("s", at: imageIs.index(imageIs.startIndex, offsetBy: 4))

            cell.imageIs.image = getImage(urlString: imageIs)
            cell.addresIs.text = "\(objectOfHomeViewModel.homeDetails[indexPath.row].address),\(objectOfHomeViewModel.homeDetails[indexPath.row].city)"
            cell.distanceIs.text = "\(objectOfHomeViewModel.homeDetails[indexPath.row].distance)km"
            cell.nameIs.text = objectOfHomeViewModel.homeDetails[indexPath.row].placeName
            cell.nationalityIs.text = objectOfHomeViewModel.homeDetails[indexPath.row].category
            cell.ratingIs.text = objectOfHomeViewModel.homeDetails[indexPath.row].rating
            if objectOfHomeViewModel.homeDetails[indexPath.row].priceRange == "1"{
                cell.rateIs.text = "₹"
            }else if objectOfHomeViewModel.homeDetails[indexPath.row].priceRange == "2"{
                cell.rateIs.text = "₹₹"
            }else if objectOfHomeViewModel.homeDetails[indexPath.row].priceRange == "3"{
                cell.rateIs.text = "₹₹₹"
            }else if objectOfHomeViewModel.homeDetails[indexPath.row].priceRange == "4"{
                cell.rateIs.text = "₹₹₹₹"
            }else if objectOfHomeViewModel.homeDetails[indexPath.row].priceRange == "5"{
                cell.rateIs.text = "₹₹₹₹₹"
            }
            cell.setShadow()
            
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("\(objectOfHomeViewModel.homeDetails[indexPath.row]._id)")
    }
    
}


extension UIViewController{
    
    func getImage(urlString: String) -> UIImage {
        
        guard let imageUrl = URL(string: urlString) else { return #imageLiteral(resourceName: "Ferrari-1200-1-1024x683") }
        
        let imageData = try?
        Data(contentsOf: imageUrl)
        
        if let imageData = imageData{
            
            guard let image = UIImage(data: imageData) else { return #imageLiteral(resourceName: "Ferrari-1200-1-1024x683") }
            
            return image
        }
        
        return #imageLiteral(resourceName: "Ferrari-1200-1-1024x683")
        
    }
}
