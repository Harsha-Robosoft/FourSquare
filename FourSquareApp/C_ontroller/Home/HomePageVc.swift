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

class HomePageVc: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, reloadHomeTable {
    func reloadTheTable() {
        tableView01.reloadData()
    }
    
    var objectOfUserDefaults = UserDefaults()
    var objectOfKeyChain = KeyChain()
    var objectOfHomeViewModel = HomeViewModel.objectOfViewModel

    var index = 0
    var manager = CLLocationManager()
    
    var homeView = 0
    
    @IBOutlet weak var mapIs: MKMapView!
    @IBOutlet weak var mapHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView01: UITableView!
    
    var delegate2: sendingIndex?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("count1 : \(objectOfHomeViewModel.homeDetails.last?.placeName.count)")
//        print("count2 : \(objectOfHomeViewModel.homeDetails.last?.rating.count)")
        
        
        tableView01.delegate = self
        tableView01.dataSource = self
        tableView01.register(UINib(nibName: "mapFile", bundle: nil), forCellReuseIdentifier: "cell")
//        tableView01.register(UINib(nibName: "favCell", bundle: nil), forCellReuseIdentifier: "cellFave")

        let call = getToken()
        
        if call != ""{
            objectOfHomeViewModel.AllFavouiretPlaceIdApiCall(tokenIs: call){ status in
                if status == true{
                    self.tableView01.reloadData()
                    print("fav id list received")
                }else{
                    print("fav id list received")
                }
            }
        }
        
   
    }
 
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView01.reloadData()
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
        
        var imageIs = objectOfHomeViewModel.homeDetails[indexPath.row].placeImage
        
        imageIs.insert("s", at: imageIs.index(imageIs.startIndex, offsetBy: 4))
        
        cell.imageIs.image = getImage(urlString: imageIs)
        cell.addresIs.text = "\(objectOfHomeViewModel.homeDetails[indexPath.row].address), \(objectOfHomeViewModel.homeDetails[indexPath.row].city)"
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
        cell._Id = objectOfHomeViewModel.homeDetails[indexPath.row]._id
        cell.buttonTatus(id: objectOfHomeViewModel.homeDetails[indexPath.row]._id)
        
        
        
        cell.delegateHomeCell = self

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        print("did select place id : \(objectOfHomeViewModel.homeDetails[indexPath.row]._id)")
        let Details = self.storyboard?.instantiateViewController(withIdentifier: "DetailsVc") as? DetailsVc
        if let vc = Details{
            vc.placeId = objectOfHomeViewModel.homeDetails[indexPath.row]._id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}


extension HomePageVc{
    
    func getToken() -> String {
        var id = ""
       let userIdIs = objectOfUserDefaults.value(forKey: "userId")
        if let idIs = userIdIs as? String{
            id = idIs
        }
        print("Home id : \(id)")
        guard let receivedTokenData = objectOfKeyChain.loadData(userId: id) else {print("utr 2")
            return ""}
        guard let receivedToken = String(data: receivedTokenData, encoding: .utf8) else {print("utr 3")
            return ""}
        print("Home token",receivedToken)
        return receivedToken
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
