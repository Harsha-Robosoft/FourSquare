//
//  SearchVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 03/01/23.
//

import UIKit
import MapKit
import CoreLocation

class SearchVc: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
//   OBJECT CREATION ---------------------------------
    
    var objectOfSearchViewModel = SearchViewModel.objectOfViewModel
    
//    VARIABLES DECLARATION -----------------------------
    
    var test = false
    var nearYou = 0
    
    
    @IBOutlet weak var search: UITextField!
    @IBOutlet weak var nearMe: UITextField!
    
//    VIEWS ------------------------------------
    @IBOutlet weak var nearMeView: UIView!
    @IBOutlet weak var tableViewAndViewMap: UIView!
    @IBOutlet weak var mapAndCollectionView: UIView!
    @IBOutlet weak var nearYouAndSuggestion: UIView!
    @IBOutlet weak var filterScreen: UIView!
    @IBOutlet weak var whiteView: UIView!
   
//    FILTER SCREEN FIRELD -------------------------------------------
    
    @IBOutlet weak var popularButton: SearchScreenButton!
    @IBOutlet weak var distanceButton: SearchScreenButton!
    @IBOutlet weak var ratingButton: SearchScreenButton!
    
    @IBOutlet weak var setRadiousField: TextFieldBorder!
    
    @IBOutlet weak var rupeesOne: SearchScreenButton!
    @IBOutlet weak var rupeesTwo: SearchScreenButton!
    @IBOutlet weak var rupeesThree: SearchScreenButton!
    @IBOutlet weak var rupeesFour: SearchScreenButton!
    
    @IBOutlet weak var acceptCreaditcardButton: FilterByButtons!
    
    @IBOutlet weak var delivaryButton: FilterByButtons!
    @IBOutlet weak var dogFriendlyButton: FilterByButtons!
    @IBOutlet weak var familyFriendlyPlace: FilterByButtons!
    @IBOutlet weak var inWalkingDistance: FilterByButtons!
    @IBOutlet weak var outDoorSeating: FilterByButtons!
    @IBOutlet weak var parkingbutton: FilterByButtons!
    @IBOutlet weak var wifiButton: FilterByButtons!
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var delivaryIMage: UIImageView!
    @IBOutlet weak var dogFriendlyImage: UIImageView!
    @IBOutlet weak var familyFriendlyImage: UIImageView!
    @IBOutlet weak var inwalkingImage: UIImageView!
    @IBOutlet weak var outdoorImage: UIImageView!
    @IBOutlet weak var parkingImage: UIImageView!
    @IBOutlet weak var wifiimage: UIImageView!

    var acceptCard = true
    var delivary = true
    var dogFriendly = true
    var familyFriendly = true
    var inWalkingDistanceNum = true
    var outDoorSeatingNum = true
    var parkingNum = true
    var wifiNum = true
    
//    MAP & COLLECTION VIEW FIELD ----------------------------------------
    var objectOfHomeViewModel = HomeViewModel.objectOfViewModel
    var manager = CLLocationManager()

    @IBOutlet weak var mapAndColectionView: MKMapView!
    @IBOutlet weak var listViewButton: UIButton!
    @IBOutlet weak var map_CollectionView: UICollectionView!

//    NEAR ME VIEW FIELDES ----------------------------
    @IBOutlet weak var useMyCurrentLocationButton: UIButton!
    
    @IBOutlet weak var searchBymap: UIButton!
    
// NEAR TOU AND SUGGESTIONS FIELDS -----------------------
    
    @IBOutlet weak var nearMeTableViewHeightconstraints: NSLayoutConstraint!
    @IBOutlet weak var nearMeTableView: UITableView!
    @IBOutlet weak var topPickButton: UIButton!
    @IBOutlet weak var pupularButton: UIButton!
    @IBOutlet weak var lunchButton: UIButton!
    @IBOutlet weak var cafeButton: UIButton!
    
//    TABLE VIEW & MAP VIEW ------------------------
    @IBOutlet weak var mapViewButton: UIButton!
    @IBOutlet weak var mapButton_TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        search.delegate = self
        nearMe.delegate = self
        addingPading()
        


        nearMeView.isHidden = true
        tableViewAndViewMap.isHidden = true
        mapAndCollectionView.isHidden = true
        nearYouAndSuggestion.isHidden = true
        filterScreen.isHidden = true
        whiteView.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        nearMeTableView.delegate = self
        nearMeTableView.dataSource = self
        
        map_CollectionView.delegate = self
        map_CollectionView.dataSource = self
        
        mapButton_TableView.delegate = self
        mapButton_TableView.dataSource = self
        mapButton_TableView.register(UINib(nibName: "mapFile", bundle: nil), forCellReuseIdentifier: "cell")
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let name = textField.placeholder {
            
            if test == false{
                
                if name == "Search"{
                    nearMeTableViewHeightconstraints.constant = 0
                    nearYou = 1
                    
                    nearMeView.isHidden = true
                    tableViewAndViewMap.isHidden = true
                    mapAndCollectionView.isHidden = true
                    nearYouAndSuggestion.isHidden = false
                    filterScreen.isHidden = true
                    whiteView.isHidden = true
                    
                    objectOfSearchViewModel.getNearCityDetailsApiCall(latToSend: String(objectOfHomeViewModel.userLocation.last?.latitude ?? "13.379162"), longToSend: String(objectOfHomeViewModel.userLocation.last?.longitude ?? "74.740373")){ status in
                        
                        if status == true{
                            self.nearMeTableViewHeightconstraints.constant = 180
                            UIView.animate(withDuration: 0.3 , animations: {
                                self.view.layoutIfNeeded()
                            }) { (status) in
                                
                            }
                            self.nearMeTableView.reloadData()
                        }else{
                            self.nearMeTableViewHeightconstraints.constant = 0
                        }
                        
                    }
                    
                }else{
                    nearYou = 0
                    nearMeView.isHidden = false
                    tableViewAndViewMap.isHidden = true
                    mapAndCollectionView.isHidden = true
                    nearYouAndSuggestion.isHidden = true
                    filterScreen.isHidden = true
                    whiteView.isHidden = true
                    
                }
            }else{
                
                nearYou = 0
                nearMeView.isHidden = true
                tableViewAndViewMap.isHidden = false
                mapAndCollectionView.isHidden = true
                nearYouAndSuggestion.isHidden = true
                filterScreen.isHidden = true
                whiteView.isHidden = true
                
                test = false
            }
            
            
            
        }

        
        }
    
    func addingPading() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: search.frame.height))
        search.leftView = paddingView
        search.leftViewMode = .always
        
        let paddingView1 = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: nearMe.frame.height))
        nearMe.leftView = paddingView1
        nearMe.leftViewMode = .always
    }
    
    @IBAction func searchFieldUsing(_ sender: Any) {
        
        if search.text?.count ?? 0 >= 3{
            
            objectOfSearchViewModel.search(latToSend: String(objectOfHomeViewModel.userLocation.last?.latitude ?? "13.379162"), longToSend: String(objectOfHomeViewModel.userLocation.last?.longitude ?? "74.740373"), textIs: search.text ?? ""){ status in
                
                if status == true{
                    
                    self.nearMeView.isHidden = true
                    self.tableViewAndViewMap.isHidden = false
                    self.mapAndCollectionView.isHidden = true
                    self.nearYouAndSuggestion.isHidden = true
                    self.filterScreen.isHidden = true
                    self.whiteView.isHidden = true
                    
                }else{
                    
                    self.nearMeView.isHidden = true
                    self.tableViewAndViewMap.isHidden = true
                    self.mapAndCollectionView.isHidden = true
                    self.nearYouAndSuggestion.isHidden = true
                    self.filterScreen.isHidden = true
                    self.whiteView.isHidden = false
                    
                }
                
                
                
            }
            
            
        }
        
    }
    
    @IBAction func nearMeFieldUsing(_ sender: Any) {
        
        if search.text?.count ?? 0 >= 3{
            
            objectOfSearchViewModel.search(latToSend: String(objectOfHomeViewModel.userLocation.last?.latitude ?? "13.379162"), longToSend: String(objectOfHomeViewModel.userLocation.last?.longitude ?? "74.740373"), textIs: search.text ?? ""){ status in
                
                if status == true{
                    
                    self.nearMeView.isHidden = true
                    self.tableViewAndViewMap.isHidden = false
                    self.mapAndCollectionView.isHidden = true
                    self.nearYouAndSuggestion.isHidden = true
                    self.filterScreen.isHidden = true
                    self.whiteView.isHidden = true
                    
                }else{
                    
                    self.nearMeView.isHidden = true
                    self.tableViewAndViewMap.isHidden = true
                    self.mapAndCollectionView.isHidden = true
                    self.nearYouAndSuggestion.isHidden = true
                    self.filterScreen.isHidden = true
                    self.whiteView.isHidden = false
                    
                }
                
                
                
            }
            
            
        }
        
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func filterButtonTapped(_ sender: Any) {
        
        nearYou = 0
        
        nearMeView.isHidden = true
        tableViewAndViewMap.isHidden = true
        mapAndCollectionView.isHidden = true
        nearYouAndSuggestion.isHidden = true
        filterScreen.isHidden = false
        whiteView.isHidden = true
        
    }
    @IBAction func popular_Distance_rating_ButtonTapped(_ sender: UIButton) {
        
        if sender.currentTitle == "Popular"{
            
            popularButton.showColour()
            distanceButton.dontShowColour()
            ratingButton.dontShowColour()
            
        }else if sender.currentTitle == "Distance"{
            
            popularButton.dontShowColour()
            distanceButton.showColour()
            ratingButton.dontShowColour()
            
        }else {
            popularButton.dontShowColour()
            distanceButton.dontShowColour()
            ratingButton.showColour()
            
        }
        
    }
    
    @IBAction func priceRangeButtonsTapped(_ sender: UIButton) {
        
        if sender.currentTitle == "₹"{
            rupeesOne.showColour()
            rupeesTwo.dontShowColour()
            rupeesThree.dontShowColour()
            rupeesFour.dontShowColour()
        }else if sender.currentTitle == "₹₹"{
            rupeesOne.dontShowColour()
            rupeesTwo.showColour()
            rupeesThree.dontShowColour()
            rupeesFour.dontShowColour()
        }
        else if sender.currentTitle == "₹₹₹"{
            rupeesOne.dontShowColour()
            rupeesTwo.dontShowColour()
            rupeesThree.showColour()
            rupeesFour.dontShowColour()
        }else{
            rupeesOne.dontShowColour()
            rupeesTwo.dontShowColour()
            rupeesThree.dontShowColour()
            rupeesFour.showColour()
            
        }
        
    }
    
    @IBAction func filterByButton(_ sender: UIButton) {
        
        if sender.currentTitle == "Accepts creadit card"{
            
            if acceptCard {
                acceptCreaditcardButton.enable()
                cardImage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.26.22 AM")
                acceptCard = false
            }else{
                acceptCreaditcardButton.disable()
                cardImage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.29.44 AM")
                acceptCard = true
            }
        }else if sender.currentTitle == "Delivary"{
            if delivary {
                delivaryButton.enable()
                delivaryIMage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.26.22 AM")
                delivary = false
            }else{
                delivaryButton.disable()
                delivaryIMage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.29.44 AM")
                delivary = true
            }
        }else if sender.currentTitle == "Dog friendly"{
            if dogFriendly  {
                dogFriendlyButton.enable()
                dogFriendlyImage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.26.22 AM")
                dogFriendly = false
            }else{
                dogFriendlyButton.disable()
                dogFriendlyImage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.29.44 AM")
                dogFriendly = true
            }
        }else if sender.currentTitle == "Family-friendly place"{
            if familyFriendly  {
                familyFriendlyPlace.enable()
                familyFriendlyImage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.26.22 AM")
                familyFriendly = false
            }else{
                familyFriendlyPlace.disable()
                familyFriendlyImage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.29.44 AM")
                familyFriendly = true
            }
        }else if sender.currentTitle == "In walking distance"{
            if inWalkingDistanceNum  {
                inWalkingDistance.enable()
                inwalkingImage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.26.22 AM")
                inWalkingDistanceNum = false
            }else{
                inWalkingDistance.disable()
                inwalkingImage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.29.44 AM")
                inWalkingDistanceNum = true
            }
        }else if sender.currentTitle == "Outdoor seating"{
            if outDoorSeatingNum  {
                outDoorSeating.enable()
                outdoorImage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.26.22 AM")
                outDoorSeatingNum = false
            }else{
                outDoorSeating.disable()
                outdoorImage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.29.44 AM")
                outDoorSeatingNum = true
            }
        }else if sender.currentTitle == "Parking"{
            if parkingNum {
                parkingbutton.enable()
                parkingImage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.26.22 AM")
                parkingNum = false
            }else{
                parkingbutton.disable()
                parkingImage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.29.44 AM")
                parkingNum = true
            }
        }else {
            if wifiNum  {
                wifiButton.enable()
                wifiimage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.26.22 AM")
                wifiNum = false
            }else{
                wifiButton.disable()
                wifiimage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.29.44 AM")
                wifiNum = true
            }
        }
        
    }
    
    
    @IBAction func useMyCurrentLocationButtonTapped(_ sender: UIButton) {
        nearYou = 0
        nearMeView.isHidden = true
        tableViewAndViewMap.isHidden = false
        mapAndCollectionView.isHidden = true
        nearYouAndSuggestion.isHidden = true
        filterScreen.isHidden = true
        whiteView.isHidden = true
        
    }
    
    @IBAction func searchInMapButtonTapped(_ sender: UIButton) {
        nearYou = 0
        nearMeView.isHidden = true
        tableViewAndViewMap.isHidden = true
        mapAndCollectionView.isHidden = false
        nearYouAndSuggestion.isHidden = true
        filterScreen.isHidden = true
        whiteView.isHidden = true
        map_CollectionView.isHidden = true
        listViewButton.isHidden = true
    }
    
    @IBAction func SuggestionButtonsTapped(_ sender: UIButton) {
        nearYou = 0
        test = true
        
        if sender.currentTitle == "Top pick"{

            let loader =   self.loader()
            objectOfHomeViewModel.apiCallForData(endPoint: "/getTopPlace", latToSend: String(objectOfHomeViewModel.userLocation.last?.latitude ?? "13.379162"), longToSend: String(objectOfHomeViewModel.userLocation.last?.longitude ?? "74.740373")){ status in
                DispatchQueue.main.async() {
                    self.stopLoader(loader: loader)
                    if status == true{
                        self.mapButton_TableView.reloadData()
                    }else{
                        self.mapButton_TableView.isHidden = true
                    }
                }
            }


        }else if sender.currentTitle == "Popular"{

            let loader =   self.loader()
            objectOfHomeViewModel.apiCallForData(endPoint: "/getPopularPlace", latToSend: String(objectOfHomeViewModel.userLocation.last?.latitude ?? "13.379162"), longToSend: String(objectOfHomeViewModel.userLocation.last?.longitude ?? "74.740373")){ status in
                DispatchQueue.main.async() {
                    self.stopLoader(loader: loader)
                    if status == true{
                        self.mapButton_TableView.reloadData()
                    }else{
                        self.mapButton_TableView.isHidden = true
                    }
                }
            }

        }else if sender.currentTitle == "Lunch"{

            let loader =   self.loader()
            objectOfHomeViewModel.apiCallForData(endPoint: "/getRestaurants", latToSend: String(objectOfHomeViewModel.userLocation.last?.latitude ?? "13.379162"), longToSend: String(objectOfHomeViewModel.userLocation.last?.longitude ?? "74.740373")){ status in
                DispatchQueue.main.async() {
                    self.stopLoader(loader: loader)
                    if status == true{

                        self.mapButton_TableView.reloadData()
                    }else{
                        self.mapButton_TableView.isHidden = true
                    }
                }
            }

        }else{


            let loader =   self.loader()
            objectOfHomeViewModel.apiCallForData(endPoint: "/getCafe", latToSend: String(objectOfHomeViewModel.userLocation.last?.latitude ?? "13.379162"), longToSend: String(objectOfHomeViewModel.userLocation.last?.longitude ?? "74.740373")){ status in
                DispatchQueue.main.async() {
                    self.stopLoader(loader: loader)
                    if status == true{
                        self.mapButton_TableView.reloadData()
                    }else{
                        self.mapButton_TableView.isHidden = true
                    }
                }
            }

        }
        
    }
    @IBAction func mapViewButtonTapped(_ sender: UIButton) {
        
        nearMeView.isHidden = true
        tableViewAndViewMap.isHidden = true
        mapAndCollectionView.isHidden = false
        nearYouAndSuggestion.isHidden = true
        filterScreen.isHidden = true
        whiteView.isHidden = true
        
        map_CollectionView.reloadData()
        
    }
    @IBAction func listViewButtonTapped(_ sender: UIButton) {
        
        nearMeView.isHidden = true
        tableViewAndViewMap.isHidden = false
        mapAndCollectionView.isHidden = true
        nearYouAndSuggestion.isHidden = true
        filterScreen.isHidden = true
        whiteView.isHidden = true
    }
    
    
}

extension SearchVc{
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
            self.objectOfHomeViewModel.updateUserLocation(lat: String(location.coordinate.latitude), long: String(location.coordinate.longitude))
            //            print("Current location: \(location)")
            manager.stopUpdatingLocation()
            render(location: location)
        }
    }
    
    
    func render(location: CLLocation) {
        let coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.mapAndColectionView.setRegion(region, animated: true)
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        self.mapAndColectionView.addAnnotation(pin)
    }
  
}


extension SearchVc{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if nearYou == 1{
            return 1
        }
            return 1
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if nearYou == 1{
            
            return objectOfSearchViewModel.nearCityData.count
        }
        return objectOfHomeViewModel.homeDetails.count
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if nearYou == 1{
        
            let cell01 = tableView.dequeueReusableCell(withIdentifier: "Header") as? SearchHeaderCell
            if let cell = cell01{
                cell.name.text = "Near by places"
            return cell
        }
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if nearYou == 1{
            
            let cell = nearMeTableView.dequeueReusableCell(withIdentifier: "cell") as! SearchBodyCell
            cell.name.text = objectOfSearchViewModel.nearCityData[indexPath.row].cityName.capitalized
            
            var imageIs = objectOfHomeViewModel.homeDetails[indexPath.row].placeImage
            
            imageIs.insert("s", at: imageIs.index(imageIs.startIndex, offsetBy: 4))
            
            cell.imageIs.image = getImage(urlString: imageIs)
            return cell
            
        }
        
        
        
        let cell = mapButton_TableView.dequeueReusableCell(withIdentifier: "cell") as! HomeTableViewCell
        
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if nearYou == 1{
            return 55
        }
        return 135
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if nearYou == 1{
            return 55
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if nearYou == 1{
            
        }else{
            
            nearMeView.isHidden = true
            tableViewAndViewMap.isHidden = true
            mapAndCollectionView.isHidden = false
            nearYouAndSuggestion.isHidden = true
            filterScreen.isHidden = true
            whiteView.isHidden = true
            
            map_CollectionView.reloadData()
        }
        
    }
    
}

extension SearchVc{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objectOfHomeViewModel.homeDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = map_CollectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! SearchCollectionView
        
        var imageIs = objectOfHomeViewModel.homeDetails[indexPath.row].placeImage
        
        imageIs.insert("s", at: imageIs.index(imageIs.startIndex, offsetBy: 4))

        cell.imageIs.image = getImage(urlString: imageIs)
        cell.address.text = "\(objectOfHomeViewModel.homeDetails[indexPath.row].address),\(objectOfHomeViewModel.homeDetails[indexPath.row].city)"
        cell.distance.text = "\(objectOfHomeViewModel.homeDetails[indexPath.row].distance)km"
        cell.name.text = objectOfHomeViewModel.homeDetails[indexPath.row].placeName
        cell.category.text = objectOfHomeViewModel.homeDetails[indexPath.row].category
        cell.rating.text = objectOfHomeViewModel.homeDetails[indexPath.row].rating
        if objectOfHomeViewModel.homeDetails[indexPath.row].priceRange == "1"{
            cell.rate.text = "₹"
        }else if objectOfHomeViewModel.homeDetails[indexPath.row].priceRange == "2"{
            cell.rate.text = "₹₹"
        }else if objectOfHomeViewModel.homeDetails[indexPath.row].priceRange == "3"{
            cell.rate.text = "₹₹₹"
        }else if objectOfHomeViewModel.homeDetails[indexPath.row].priceRange == "4"{
            cell.rate.text = "₹₹₹₹"
        }else if objectOfHomeViewModel.homeDetails[indexPath.row].priceRange == "5"{
            cell.rate.text = "₹₹₹₹₹"
        }
        cell.setShadow()
        
        return cell
    }

    
}
