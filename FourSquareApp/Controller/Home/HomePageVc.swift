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
    
    var getTheToken_shared = GetToken._shared
    var homeViewModel_shared = HomeViewModel._shared

    var index = 0
    var manager = CLLocationManager()
    var homeView = 0
    
    @IBOutlet weak var mapIs: MKMapView!
    @IBOutlet weak var mapHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView01: UITableView!
    
    var delegate2: sendingIndex?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView01.delegate = self
        tableView01.dataSource = self
        tableView01.register(UINib(nibName: "mapFile", bundle: nil), forCellReuseIdentifier: "cell")
        let call = getTheToken_shared.getToken()
        if call != ""{
            homeViewModel_shared.AllFavouiretPlaceIdApiCall(tokenTosend: call){ status in
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
            callIndexApi(endPoint: "/getNearPlace")
        }else if index == 1{
            callIndexApi(endPoint: "/getTopPlace")
        }else if index == 2{
            callIndexApi(endPoint: "/getPopularPlace")
        }else if index == 3{
            callIndexApi(endPoint: "/getRestaurants")
        }else if index == 4{
            callIndexApi(endPoint: "/getCafe")
        }else{ }
    }
    
    func callIndexApi(endPoint: String) {
        let loader =   self.loader()
        homeViewModel_shared.apiCallForData(endPoint: endPoint, latToSend: String(homeViewModel_shared.userLocation.last?.latitude ?? "13.379162"), longToSend: String(homeViewModel_shared.userLocation.last?.longitude ?? "74.740373")){ status in
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
            homeViewModel_shared.updateUserLocation(lat: String(location.coordinate.latitude), long: String(location.coordinate.longitude))
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
        if homeViewModel_shared.homeDetails.count != 0{
            return homeViewModel_shared.homeDetails.count
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
        var imageIs = homeViewModel_shared.homeDetails[indexPath.row].placeImage
        imageIs.insert("s", at: imageIs.index(imageIs.startIndex, offsetBy: 4))
        cell.imageIs.image = getImage(urlString: imageIs)
        cell.addresIs.text = "\(homeViewModel_shared.homeDetails[indexPath.row].address), \(homeViewModel_shared.homeDetails[indexPath.row].city)"
        cell.distanceIs.text = "\(homeViewModel_shared.homeDetails[indexPath.row].distance)km"
        cell.nameIs.text = homeViewModel_shared.homeDetails[indexPath.row].placeName
        cell.nationalityIs.text = homeViewModel_shared.homeDetails[indexPath.row].category
        cell.ratingIs.text = homeViewModel_shared.homeDetails[indexPath.row].rating
        if homeViewModel_shared.homeDetails[indexPath.row].priceRange == "1"{
            cell.rateIs.text = "₹"
        }else if homeViewModel_shared.homeDetails[indexPath.row].priceRange == "2"{
            cell.rateIs.text = "₹₹"
        }else if homeViewModel_shared.homeDetails[indexPath.row].priceRange == "3"{
            cell.rateIs.text = "₹₹₹"
        }else if homeViewModel_shared.homeDetails[indexPath.row].priceRange == "4"{
            cell.rateIs.text = "₹₹₹₹"
        }else if homeViewModel_shared.homeDetails[indexPath.row].priceRange == "5"{
            cell.rateIs.text = "₹₹₹₹₹"
        }
        cell.setShadow()
        cell._Id = homeViewModel_shared.homeDetails[indexPath.row]._id
        cell.buttonStatus(id: homeViewModel_shared.homeDetails[indexPath.row]._id)
        cell.delegateHomeCell = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Details = self.storyboard?.instantiateViewController(withIdentifier: "DetailsVc") as? DetailsVc
        if let vc = Details{
            vc.placeId = homeViewModel_shared.homeDetails[indexPath.row]._id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension HomePageVc{
    func reloadTheTable() {
        tableView01.reloadData()
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
