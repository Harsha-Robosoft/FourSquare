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
    var objectOfUserDefaults = UserDefaults()
    var objectOfKeyChain = KeyChain()
//    VARIABLES DECLARATION -----------------------------
    
    var test = false
    var nearYou = 0
    var filterTapped = 0
    var poplular_Distance_RatingButton = ""
    var rateStatus = 0
    var searching = 0
    var filterSearchIs = 0
    var mapViewTapped = 0
    
    var showFilterScreen = 0
    
    var annotation = [[String: Any]]()
    
    @IBOutlet weak var filter: UIButton!
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
        
        if showFilterScreen == 1{
            nearMeView.isHidden = true
            tableViewAndViewMap.isHidden = true
            mapAndCollectionView.isHidden = true
            nearYouAndSuggestion.isHidden = true
            filterScreen.isHidden = false
            whiteView.isHidden = true
            
            filter.setTitle("Done", for: .normal)
            filter.setImage(nil, for: .normal)

        }else{
            nearMeView.isHidden = true
            tableViewAndViewMap.isHidden = true
            mapAndCollectionView.isHidden = true
            nearYouAndSuggestion.isHidden = true
            filterScreen.isHidden = true
            whiteView.isHidden = false
        }

        search.delegate = self
        nearMe.delegate = self
        addingPading()

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
            
            if filterTapped == 0{
                if test == false{
                    
                    if name == "Search"{
                        nearMeTableViewHeightconstraints.constant = 0
                        nearYou = 1
                        filterSearchIs = 0
                        searching = 0
                        
                        nearMeView.isHidden = true
                        tableViewAndViewMap.isHidden = true
                        mapAndCollectionView.isHidden = true
                        nearYouAndSuggestion.isHidden = false
                        filterScreen.isHidden = true
                        whiteView.isHidden = true
                        
                        filter.setTitle(nil, for: .normal)
                        filter.setImage( #imageLiteral(resourceName: "filter_icon"), for: .normal)
                        
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
                        
                        print("naana neena naana neena naana neena naana neena naana neena naana neena naana neena ")
                        searching = 0
                        filter.setTitle(nil, for: .normal)
                        filter.setImage( #imageLiteral(resourceName: "filter_icon"), for: .normal)
                        nearYou = 0
                        filterSearchIs = 0
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
            }else{}
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
        
        let tokenIs = getToken()
        if tokenIs != ""{
            if filterTapped == 0{
                if search.text?.count ?? 0 >= 3{
                    objectOfSearchViewModel.search(tokenToSend: tokenIs, latToSend: String(objectOfHomeViewModel.userLocation.last?.latitude ?? "13.379162"), longToSend: String(objectOfHomeViewModel.userLocation.last?.longitude ?? "74.740373"), textIs: search.text ?? ""){ status in
                        if status == true{
                            
                            self.searching = 1
                            self.nearYou = 0
                            self.filterSearchIs = 0
                            self.nearMeView.isHidden = true
                            self.tableViewAndViewMap.isHidden = false
                            self.mapAndCollectionView.isHidden = true
                            self.nearYouAndSuggestion.isHidden = true
                            self.filterScreen.isHidden = true
                            self.whiteView.isHidden = true
                            self.mapButton_TableView.reloadData()
                        }else{
                            self.nearMeView.isHidden = true
                            self.tableViewAndViewMap.isHidden = true
                            self.mapAndCollectionView.isHidden = true
                            self.nearYouAndSuggestion.isHidden = true
                            self.filterScreen.isHidden = true
                            self.whiteView.isHidden = false
                        }
                    }
                }else{self.nearMeView.isHidden = true
                    self.tableViewAndViewMap.isHidden = true
                    self.mapAndCollectionView.isHidden = true
                    self.nearYouAndSuggestion.isHidden = false
                    self.filterScreen.isHidden = true
                    self.whiteView.isHidden = true
                    
                }
            }else{}
        }else{
            
            let refreshAlert = UIAlertController(title: "ALERT", message: "Are you not loged in. Pleace login", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                
                self.navigationController?.popToRootViewController(animated: true)
                print("Handle Ok logic here")
                
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            present(refreshAlert, animated: true, completion: nil)
        }

    }
    
    @IBAction func nearMeFieldUsing(_ sender: Any) {
        
        let tokenIs = getToken()
        if tokenIs != ""{
            if filterTapped == 0{
                if search.text?.count ?? 0 >= 3{
                    objectOfSearchViewModel.search(tokenToSend: tokenIs, latToSend: String(objectOfHomeViewModel.userLocation.last?.latitude ?? "13.379162"), longToSend: String(objectOfHomeViewModel.userLocation.last?.longitude ?? "74.740373"), textIs: search.text ?? ""){ status in
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
                }else{}
            }else{}
        }else{
            
            let refreshAlert = UIAlertController(title: "ALERT", message: "Are you not loged in. Pleace login", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                
                self.navigationController?.popToRootViewController(animated: true)
                print("Handle Ok logic here")
                
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            present(refreshAlert, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        
        let tokenIs = getToken()
        
        if tokenIs != ""{
            
            if sender.currentTitle == nil{
                filterTapped = 1
                nearYou = 0
                
                nearMeView.isHidden = true
                tableViewAndViewMap.isHidden = true
                mapAndCollectionView.isHidden = true
                nearYouAndSuggestion.isHidden = true
                filterScreen.isHidden = false
                whiteView.isHidden = true
                
                filter.setTitle("Done", for: .normal)
                filter.setImage(nil, for: .normal)
            }else{
                
                var dictionaryIs = [String: Any]()
                dictionaryIs["latitude"] = String(objectOfHomeViewModel.userLocation.last?.latitude ?? "13.379162")
                dictionaryIs["longitude"] = String(objectOfHomeViewModel.userLocation.last?.longitude ?? "74.740373")
                
                
                    dictionaryIs["text"] = search.text
                
                if setRadiousField.text != ""{
                    dictionaryIs["radius"] = setRadiousField.text
                }

                if poplular_Distance_RatingButton != ""{
                    dictionaryIs["sortBy"] = poplular_Distance_RatingButton
                }
                
                if rateStatus != 0{
                    dictionaryIs["pricr"] = rateStatus
                }
                if acceptCard == false{
                    dictionaryIs["acceptedCredit"] = true
                }
                if delivary == false{
                    dictionaryIs["delivery"] = true
                }
                if dogFriendly == false{
                    dictionaryIs["dogFriendly"] = true
                }
                if familyFriendly == false{
                    dictionaryIs["familyFriendly"] = true
                }
                if inWalkingDistanceNum == false{
                    dictionaryIs["inWalkingDistance"] = true
                }
                if outDoorSeatingNum == false{
                    dictionaryIs["outdoorDining"] = true
                }
                if parkingNum == false{
                    dictionaryIs["parking"] = true
                }
                if wifiNum == false{
                    dictionaryIs["wifi"] = true
                }
                
                
                objectOfSearchViewModel.searchWithFilterApiCall(tokenToSend: tokenIs, parameterDictionary: dictionaryIs){ status in
                    
                    if status == true{
                        self.searching = 0
                        self.nearYou = 0
                        self.filterSearchIs = 1
                        
                        self.nearMeView.isHidden = true
                        self.tableViewAndViewMap.isHidden = false
                        self.mapAndCollectionView.isHidden = true
                        self.nearYouAndSuggestion.isHidden = true
                        self.filterScreen.isHidden = true
                        self.whiteView.isHidden = true
                        self.filter.setTitle(nil, for: .normal)
                        self.filter.setImage(#imageLiteral(resourceName: "filter_icon"), for: .normal)
                        self.mapButton_TableView.reloadData()
                    }else{
                                                
                        self.nearMeView.isHidden = true
                        self.tableViewAndViewMap.isHidden = true
                        self.mapAndCollectionView.isHidden = true
                        self.nearYouAndSuggestion.isHidden = true
                        self.filterScreen.isHidden = true
                        self.whiteView.isHidden = false
                        
                    }
                    
                }
                
                print("result : \(dictionaryIs)")
                
            }
            
        }else{
            let refreshAlert = UIAlertController(title: "ALERT", message: "Are you not loged in. Pleace login", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                
                self.navigationController?.popToRootViewController(animated: true)
                print("Handle Ok logic here")
                
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            present(refreshAlert, animated: true, completion: nil)
            
        }

        
        
    }
    @IBAction func popular_Distance_rating_ButtonTapped(_ sender: UIButton) {
        
        poplular_Distance_RatingButton = sender.currentTitle ?? ""
        
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
            rateStatus = 1
        }else if sender.currentTitle == "₹₹"{
            rupeesOne.dontShowColour()
            rupeesTwo.showColour()
            rupeesThree.dontShowColour()
            rupeesFour.dontShowColour()
            rateStatus = 2
        }
        else if sender.currentTitle == "₹₹₹"{
            rupeesOne.dontShowColour()
            rupeesTwo.dontShowColour()
            rupeesThree.showColour()
            rupeesFour.dontShowColour()
            rateStatus = 3
        }else{
            rupeesOne.dontShowColour()
            rupeesTwo.dontShowColour()
            rupeesThree.dontShowColour()
            rupeesFour.showColour()
            rateStatus = 4
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
        let tokenIs = getToken()
  
        if tokenIs != ""{
            
            nearYou = 0
            nearMeView.isHidden = true
            tableViewAndViewMap.isHidden = false
            mapAndCollectionView.isHidden = true
            nearYouAndSuggestion.isHidden = true
            filterScreen.isHidden = true
            whiteView.isHidden = true
            objectOfSearchViewModel.search(tokenToSend: tokenIs, latToSend: String(objectOfHomeViewModel.userLocation.last?.latitude ?? "13.379162"), longToSend: String(objectOfHomeViewModel.userLocation.last?.longitude ?? "74.740373"), textIs: ""){ status in
                if status == true{
                    
                    self.searching = 1
                    self.nearYou = 0
                    self.filterSearchIs = 0
                    self.nearMeView.isHidden = true
                    self.tableViewAndViewMap.isHidden = false
                    self.mapAndCollectionView.isHidden = true
                    self.nearYouAndSuggestion.isHidden = true
                    self.filterScreen.isHidden = true
                    self.whiteView.isHidden = true
                    self.mapButton_TableView.reloadData()
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
        map_CollectionView.isHidden = false
        listViewButton.isHidden = false
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
            render(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
    }
    
    
    func render(latitude: Double, longitude: Double) {
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.mapAndColectionView.setRegion(region, animated: true)
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        self.mapAndColectionView.addAnnotation(pin)
    }
    
    
    func setAnnotation(locations: [[String: Any]]) {
        
        for location in locations{
            let coordinate = CLLocationCoordinate2DMake(location["latitude"] as? CLLocationDegrees ?? 13.3409, location["longitude"] as? CLLocationDegrees ?? 74.7421)
            let span = MKCoordinateSpan(latitudeDelta: 10.0, longitudeDelta: 10.0)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            self.mapAndColectionView.setRegion(region, animated: true)
            let pin = MKPointAnnotation()
            pin.title = location["title"] as? String
            pin.coordinate = coordinate
            self.mapAndColectionView.addAnnotation(pin)
        }
        
        
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
        } else if searching == 1{
           return objectOfSearchViewModel.searchDetaisl.count
        }else if filterSearchIs == 1{
            return objectOfSearchViewModel.filterSearchDetails.count
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
            
            var imageIs = objectOfSearchViewModel.nearCityData[indexPath.row].cityImage
            
            imageIs.insert("s", at: imageIs.index(imageIs.startIndex, offsetBy: 4))
            
            cell.imageIs.image = getImage(urlString: imageIs)
            return cell
            
        }else if searching == 1{
            
            let cell = mapButton_TableView.dequeueReusableCell(withIdentifier: "cell") as! HomeTableViewCell
            var imageIs = objectOfSearchViewModel.searchDetaisl[indexPath.row].placeImage
            imageIs.insert("s", at: imageIs.index(imageIs.startIndex, offsetBy: 4))
            cell.imageIs.image = getImage(urlString: imageIs)
            cell.addresIs.text = "\(objectOfSearchViewModel.searchDetaisl[indexPath.row].address),\(objectOfSearchViewModel.searchDetaisl[indexPath.row].city)"
            cell.distanceIs.text = "\(objectOfSearchViewModel.searchDetaisl[indexPath.row].distance)km"
            cell.nameIs.text = objectOfSearchViewModel.searchDetaisl[indexPath.row].placeName
            cell.nationalityIs.text = objectOfSearchViewModel.searchDetaisl[indexPath.row].category
            cell.ratingIs.text = objectOfSearchViewModel.searchDetaisl[indexPath.row].rating
            if objectOfSearchViewModel.searchDetaisl[indexPath.row].priceRange == "1"{
                cell.rateIs.text = "₹"
            }else if objectOfSearchViewModel.searchDetaisl[indexPath.row].priceRange == "2"{
                cell.rateIs.text = "₹₹"
            }else if objectOfSearchViewModel.searchDetaisl[indexPath.row].priceRange == "3"{
                cell.rateIs.text = "₹₹₹"
            }else if objectOfSearchViewModel.searchDetaisl[indexPath.row].priceRange == "4"{
                cell.rateIs.text = "₹₹₹₹"
            }else if objectOfSearchViewModel.searchDetaisl[indexPath.row].priceRange == "5"{
                cell.rateIs.text = "₹₹₹₹₹"
            }
            cell.setShadow()
            
            return cell

        }else if filterSearchIs == 1{
            
            let cell = mapButton_TableView.dequeueReusableCell(withIdentifier: "cell") as! HomeTableViewCell
            var imageIs = objectOfSearchViewModel.filterSearchDetails[indexPath.row].placeImage
            imageIs.insert("s", at: imageIs.index(imageIs.startIndex, offsetBy: 4))
            cell.imageIs.image = getImage(urlString: imageIs)
            cell.addresIs.text = "\(objectOfSearchViewModel.filterSearchDetails[indexPath.row].address),\(objectOfSearchViewModel.filterSearchDetails[indexPath.row].city)"
            cell.distanceIs.text = "\(objectOfSearchViewModel.filterSearchDetails[indexPath.row].distance)km"
            cell.nameIs.text = objectOfSearchViewModel.filterSearchDetails[indexPath.row].placeName
            cell.nationalityIs.text = objectOfSearchViewModel.filterSearchDetails[indexPath.row].category
            cell.ratingIs.text = objectOfSearchViewModel.filterSearchDetails[indexPath.row].rating
            if objectOfSearchViewModel.filterSearchDetails[indexPath.row].priceRange == "1"{
                cell.rateIs.text = "₹"
            }else if objectOfSearchViewModel.filterSearchDetails[indexPath.row].priceRange == "2"{
                cell.rateIs.text = "₹₹"
            }else if objectOfSearchViewModel.filterSearchDetails[indexPath.row].priceRange == "3"{
                cell.rateIs.text = "₹₹₹"
            }else if objectOfSearchViewModel.filterSearchDetails[indexPath.row].priceRange == "4"{
                cell.rateIs.text = "₹₹₹₹"
            }else if objectOfSearchViewModel.filterSearchDetails[indexPath.row].priceRange == "5"{
                cell.rateIs.text = "₹₹₹₹₹"
            }
            cell.setShadow()
            
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
 
            let tokenIs = getToken()
    
            if tokenIs != ""{
                
                nearYou = 0
                nearMeView.isHidden = true
                tableViewAndViewMap.isHidden = false
                mapAndCollectionView.isHidden = true
                nearYouAndSuggestion.isHidden = true
                filterScreen.isHidden = true
                whiteView.isHidden = true
                objectOfSearchViewModel.search(tokenToSend: tokenIs, latToSend: String(objectOfHomeViewModel.userLocation.last?.latitude ?? "13.379162"), longToSend: String(objectOfHomeViewModel.userLocation.last?.longitude ?? "74.740373"), textIs: objectOfSearchViewModel.nearCityData[indexPath.row].cityName){ status in
                    if status == true{
                        
                        self.searching = 1
                        self.nearYou = 0
                        self.filterSearchIs = 0
                        self.nearMeView.isHidden = true
                        self.tableViewAndViewMap.isHidden = false
                        self.mapAndCollectionView.isHidden = true
                        self.nearYouAndSuggestion.isHidden = true
                        self.filterScreen.isHidden = true
                        self.whiteView.isHidden = true
                        self.mapButton_TableView.reloadData()
//                        self.map_CollectionView.reloadData()
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

        }else if searching == 1{
            print("search id didselect: ",objectOfSearchViewModel.searchDetaisl[indexPath.row]._id)
            
            let Details = self.storyboard?.instantiateViewController(withIdentifier: "DetailsVc") as? DetailsVc
            if let vc = Details{
                vc.placeId = objectOfSearchViewModel.searchDetaisl[indexPath.row]._id
                self.navigationController?.pushViewController(vc, animated: true)
            }
            

        }else if filterSearchIs == 1{
            print("Filter search id didselect ",objectOfSearchViewModel.filterSearchDetails[indexPath.row]._id)
            
            let Details = self.storyboard?.instantiateViewController(withIdentifier: "DetailsVc") as? DetailsVc
            if let vc = Details{
                vc.placeId = objectOfSearchViewModel.filterSearchDetails[indexPath.row]._id
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            print("home details if didselect", objectOfHomeViewModel.homeDetails[indexPath.row]._id)
            
            let Details = self.storyboard?.instantiateViewController(withIdentifier: "DetailsVc") as? DetailsVc
            if let vc = Details{
                vc.placeId = objectOfHomeViewModel.homeDetails[indexPath.row]._id
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
}

extension SearchVc{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching == 1{
            return objectOfSearchViewModel.searchDetaisl.count
        }
        return objectOfHomeViewModel.homeDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if searching == 1{
            
            let cell = map_CollectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! SearchCollectionView
            
            var imageIs = objectOfSearchViewModel.searchDetaisl[indexPath.row].placeImage
            
            imageIs.insert("s", at: imageIs.index(imageIs.startIndex, offsetBy: 4))

            cell.imageIs.image = getImage(urlString: imageIs)
            cell.address.text = "\(objectOfSearchViewModel.searchDetaisl[indexPath.row].address),\(objectOfSearchViewModel.searchDetaisl[indexPath.row].city)"
            cell.distance.text = "\(objectOfSearchViewModel.searchDetaisl[indexPath.row].distance)km"
            cell.name.text = objectOfSearchViewModel.searchDetaisl[indexPath.row].placeName
            cell.category.text = objectOfSearchViewModel.searchDetaisl[indexPath.row].category
            cell.rating.text = objectOfSearchViewModel.searchDetaisl[indexPath.row].rating
            if objectOfSearchViewModel.searchDetaisl[indexPath.row].priceRange == "1"{
                cell.rate.text = "₹"
            }else if objectOfSearchViewModel.searchDetaisl[indexPath.row].priceRange == "2"{
                cell.rate.text = "₹₹"
            }else if objectOfSearchViewModel.searchDetaisl[indexPath.row].priceRange == "3"{
                cell.rate.text = "₹₹₹"
            }else if objectOfSearchViewModel.searchDetaisl[indexPath.row].priceRange == "4"{
                cell.rate.text = "₹₹₹₹"
            }else if objectOfSearchViewModel.searchDetaisl[indexPath.row].priceRange == "5"{
                cell.rate.text = "₹₹₹₹₹"
            }
            
            annotation.append(["title":objectOfSearchViewModel.searchDetaisl[indexPath.row].placeName,"latitude": objectOfSearchViewModel.searchDetaisl[indexPath.row].longitude,"longitude": objectOfSearchViewModel.searchDetaisl[indexPath.row].longitude])
            
            setAnnotation(locations: annotation)
            
            cell.setShadow()
            
            return cell
        }else if filterSearchIs == 1{
            
            let cell = map_CollectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! SearchCollectionView
            
            var imageIs = objectOfSearchViewModel.filterSearchDetails[indexPath.row].placeImage
            
            imageIs.insert("s", at: imageIs.index(imageIs.startIndex, offsetBy: 4))

            cell.imageIs.image = getImage(urlString: imageIs)
            cell.address.text = "\(objectOfSearchViewModel.filterSearchDetails[indexPath.row].address),\(objectOfSearchViewModel.filterSearchDetails[indexPath.row].city)"
            cell.distance.text = "\(objectOfSearchViewModel.filterSearchDetails[indexPath.row].distance)km"
            cell.name.text = objectOfSearchViewModel.filterSearchDetails[indexPath.row].placeName
            cell.category.text = objectOfSearchViewModel.filterSearchDetails[indexPath.row].category
            cell.rating.text = objectOfSearchViewModel.filterSearchDetails[indexPath.row].rating
            if objectOfSearchViewModel.filterSearchDetails[indexPath.row].priceRange == "1"{
                cell.rate.text = "₹"
            }else if objectOfSearchViewModel.filterSearchDetails[indexPath.row].priceRange == "2"{
                cell.rate.text = "₹₹"
            }else if objectOfSearchViewModel.filterSearchDetails[indexPath.row].priceRange == "3"{
                cell.rate.text = "₹₹₹"
            }else if objectOfSearchViewModel.filterSearchDetails[indexPath.row].priceRange == "4"{
                cell.rate.text = "₹₹₹₹"
            }else if objectOfSearchViewModel.filterSearchDetails[indexPath.row].priceRange == "5"{
                cell.rate.text = "₹₹₹₹₹"
            }
            
            annotation.append(["title":objectOfSearchViewModel.filterSearchDetails[indexPath.row].placeName,"latitude": objectOfSearchViewModel.filterSearchDetails[indexPath.row].longitude,"longitude": objectOfSearchViewModel.filterSearchDetails[indexPath.row].longitude])
            
            setAnnotation(locations: annotation)
            
            cell.setShadow()
            return cell
        }
            
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
        
        annotation.append(["title":objectOfHomeViewModel.homeDetails[indexPath.row].placeName,"latitude": objectOfHomeViewModel.homeDetails[indexPath.row].longitude,"longitude": objectOfHomeViewModel.homeDetails[indexPath.row].longitude])
        
        setAnnotation(locations: annotation)
        
            cell.setShadow()
            return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if searching == 1{
            let Details = self.storyboard?.instantiateViewController(withIdentifier: "DetailsVc") as? DetailsVc
            if let vc = Details{
                vc.placeId = objectOfSearchViewModel.searchDetaisl[indexPath.row]._id
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else if filterSearchIs == 1{
            let Details = self.storyboard?.instantiateViewController(withIdentifier: "DetailsVc") as? DetailsVc
            if let vc = Details{
                vc.placeId = objectOfSearchViewModel.filterSearchDetails[indexPath.row]._id
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            let Details = self.storyboard?.instantiateViewController(withIdentifier: "DetailsVc") as? DetailsVc
            if let vc = Details{
                vc.placeId = objectOfHomeViewModel.homeDetails[indexPath.row]._id
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

extension SearchVc{
    func getToken() -> String {
        var id = ""
       let userIdIs = objectOfUserDefaults.value(forKey: "userId")
        if let idIs = userIdIs as? String{
            id = idIs
        }
        print("Search id : \(id)")
        guard let receivedTokenData = objectOfKeyChain.loadData(userId: id) else {print("utr 2")
            return ""}
        guard let receivedToken = String(data: receivedTokenData, encoding: .utf8) else {print("utr 3")
            return ""}
        print("Search token",receivedToken)
        return receivedToken
    }
}
