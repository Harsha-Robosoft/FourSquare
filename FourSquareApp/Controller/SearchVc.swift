//
//  SearchVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 03/01/23.
//

import UIKit
import MapKit
import CoreLocation

class SearchVc: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, reloadHomeTable, reloadHomeTable2 {
    //   OBJECT CREATION ---------------------------------
    var objectOfSearchViewModel = SearchViewModel.objectOfViewModel
    var getTheToken = GetToken.getTheUserToken

    //    VARIABLES DECLARATION -----------------------------
    
    var filterElement = ["Accepts creadit card","Delivary","Dog friendly","Family-friendly place","In walking distance","Outdoor seating","Parking","Wi-fi"]
    
    
    var cell00: FilterButtonTableCell?
    
    var test = false
    var nearYou = 0
    var filterTapped = 0
    var filterTableToShow = 0
    var poplular_Distance_RatingButton = ""
    var rateStatus = 0
    var searching = 0
    var filterSearchIs = 0
    var mapViewTapped = 0
    var rupeesOneStatus = 0
    var rupeesTwoStatus = 0
    var rupeesThreeStatus = 0
    var rupeesFourStatus = 0
    var popularStatus = 0
    var distanceStatus = 0
    var popRatingStatus = 0
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
    
    @IBOutlet weak var filterButtonTable: UITableView!
    
    
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
    @IBOutlet weak var acceptCardLabel: FilterLabel!
    @IBOutlet weak var delivaryLabel: FilterLabel!
    @IBOutlet weak var dogFriendlyLabel: FilterLabel!
    @IBOutlet weak var familyFriendlyLabel: FilterLabel!
    @IBOutlet weak var inWalkingDistanceLabel: FilterLabel!
    @IBOutlet weak var outdoorLabel: FilterLabel!
    @IBOutlet weak var parkingLabel: FilterLabel!
    @IBOutlet weak var wiFiLabel: FilterLabel!
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
        filterButtonTable.delegate = self
        filterButtonTable.dataSource = self
        mapButton_TableView.register(UINib(nibName: "mapFile", bundle: nil), forCellReuseIdentifier: "cell")
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let name = textField.placeholder {
            if filterTapped == 0 && showFilterScreen == 0{
                if test == false{
                    if name == "Search"{
                        nearMeTableViewHeightconstraints.constant = 0
                        nearYou = 1
                        filterSearchIs = 0
                        searching = 0
                        filterTableToShow = 0
                        nearMeView.isHidden = true
                        tableViewAndViewMap.isHidden = true
                        mapAndCollectionView.isHidden = true
                        nearYouAndSuggestion.isHidden = false
                        filterScreen.isHidden = true
                        whiteView.isHidden = true
                        filter.setTitle(nil, for: .normal)
                        filter.setImage( #imageLiteral(resourceName: "filter_icon"), for: .normal)
                        if objectOfSearchViewModel.nearCityData.count == 0{
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
                            self.nearMeTableViewHeightconstraints.constant = 180
                            self.nearMeTableView.reloadData()
                        }
                    }else{
                        manager.desiredAccuracy = kCLLocationAccuracyBest
                        manager.delegate = self
                        manager.requestWhenInUseAuthorization()
                        manager.startUpdatingLocation()
                        nearYou = 0
                        filterSearchIs = 0
                        searching = 0
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
            }else{
                if name != "Search"{
                    manager.desiredAccuracy = kCLLocationAccuracyBest
                    manager.delegate = self
                    manager.requestWhenInUseAuthorization()
                    manager.startUpdatingLocation()
                    nearYou = 0
                    filterSearchIs = 0
                    searching = 0
                    filter.setTitle(nil, for: .normal)
                    filter.setImage( #imageLiteral(resourceName: "filter_icon"), for: .normal)
                    nearMeView.isHidden = false
                    tableViewAndViewMap.isHidden = true
                    mapAndCollectionView.isHidden = true
                    nearYouAndSuggestion.isHidden = true
                    filterScreen.isHidden = true
                    whiteView.isHidden = true
                    showFilterScreen = 0
                    filterTapped = 0
                }
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
        let tokenIs = getTheToken.getToken()
        if tokenIs != ""{
            if filterTapped == 0 && showFilterScreen == 0{
                if search.text?.count ?? 0 >= 3{
                    objectOfSearchViewModel.search(tokenToSend: tokenIs, latToSend: String(objectOfHomeViewModel.userLocation.last?.latitude ?? "13.379162"), longToSend: String(objectOfHomeViewModel.userLocation.last?.longitude ?? "74.740373"), textToSend: search.text ?? ""){ status in
                        if status == true{
                            self.searching = 1
                            self.nearYou = 0
                            self.filterSearchIs = 0
                            self.filterTableToShow = 0
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
            let refreshAlert = UIAlertController(title: "ALERT", message: "You are not loged in. Pleace login", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.navigationController?.popToRootViewController(animated: true)
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            }))
            present(refreshAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func nearMeFieldUsing(_ sender: Any) {
        let tokenIs = getTheToken.getToken()
        if tokenIs != ""{
            if filterTapped == 0{
                if search.text?.count ?? 0 >= 3{
                    objectOfSearchViewModel.search(tokenToSend: tokenIs, latToSend: String(objectOfHomeViewModel.userLocation.last?.latitude ?? "13.379162"), longToSend: String(objectOfHomeViewModel.userLocation.last?.longitude ?? "74.740373"), textToSend: search.text ?? ""){ status in
                        if status == true{
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
                }else{}
            }else{}
        }else{
            let refreshAlert = UIAlertController(title: "ALERT", message: "You are not loged in. Pleace login", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.navigationController?.popToRootViewController(animated: true)
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            }))
            present(refreshAlert, animated: true, completion: nil)
        }
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        let tokenIs = getTheToken.getToken()
        if tokenIs != ""{
            if sender.currentTitle == nil{
                filterTapped = 1
                filterTableToShow = 1
                nearYou = 0
                searching = 0
                filterSearchIs = 0
                nearMeView.isHidden = true
                tableViewAndViewMap.isHidden = true
                mapAndCollectionView.isHidden = true
                nearYouAndSuggestion.isHidden = true
                filterScreen.isHidden = false
                whiteView.isHidden = true
                filter.setTitle("Done", for: .normal)
                filter.setImage(nil, for: .normal)
                filterButtonTable.reloadData()
            }else{
                var dictionaryIs = [String: Any]()
                dictionaryIs["latitude"] = String(objectOfHomeViewModel.userLocation.last?.latitude ?? "13.379162")
                dictionaryIs["longitude"] = String(objectOfHomeViewModel.userLocation.last?.longitude ?? "74.740373")
                dictionaryIs["text"] = search.text
                if setRadiousField.text != "" && Int(setRadiousField.text ?? "") != nil{
                    dictionaryIs["radius"] = setRadiousField.text
                }
                if poplular_Distance_RatingButton != ""{
                    dictionaryIs["sortBy"] = poplular_Distance_RatingButton
                }
                if rateStatus != 0{
                    dictionaryIs["price"] = rateStatus
                }
                if objectOfSearchViewModel.userFilterChoice.contains("Accepts creadit card"){
                    dictionaryIs["acceptedCredit"] = true
                }
                if objectOfSearchViewModel.userFilterChoice.contains("Delivary"){
                    dictionaryIs["delivery"] = true
                }
                if objectOfSearchViewModel.userFilterChoice.contains("Dog friendly"){
                    dictionaryIs["dogFriendly"] = true
                }
                if objectOfSearchViewModel.userFilterChoice.contains("Family-friendly place"){
                    dictionaryIs["familyFriendly"] = true
                }
                if objectOfSearchViewModel.userFilterChoice.contains("In walking distance"){
                    dictionaryIs["inWalkingDistance"] = true
                }
                if objectOfSearchViewModel.userFilterChoice.contains("Outdoor seating"){
                    dictionaryIs["outdoorDining"] = true
                }
                if objectOfSearchViewModel.userFilterChoice.contains("Parking"){
                    dictionaryIs["parking"] = true
                }
                if objectOfSearchViewModel.userFilterChoice.contains("Wi-fi"){
                    dictionaryIs["wifi"] = true
                }
                
                print("dic",dictionaryIs)
                
                objectOfSearchViewModel.searchWithFilterApiCall(tokenToSend: tokenIs, parameterDictionary: dictionaryIs){ status in
                    if status == true{
                        self.searching = 0
                        self.nearYou = 0
                        self.filterSearchIs = 1
                        self.filterTableToShow = 0
                        self.nearMeView.isHidden = true
                        self.tableViewAndViewMap.isHidden = false
                        self.mapAndCollectionView.isHidden = true
                        self.nearYouAndSuggestion.isHidden = true
                        self.filterScreen.isHidden = true
                        self.whiteView.isHidden = true
                        self.filter.setTitle(nil, for: .normal)
                        self.filter.setImage(#imageLiteral(resourceName: "filter_icon"), for: .normal)
                        self.search.text = ""
                        self.mapButton_TableView.reloadData()
                        self.objectOfSearchViewModel.userFilterChoice.removeAll()
                    }else{
                        self.nearMeView.isHidden = true
                        self.tableViewAndViewMap.isHidden = true
                        self.mapAndCollectionView.isHidden = true
                        self.nearYouAndSuggestion.isHidden = true
                        self.filterScreen.isHidden = true
                        self.whiteView.isHidden = false
                        self.filter.setTitle(nil, for: .normal)
                        self.filter.setImage(#imageLiteral(resourceName: "filter_icon"), for: .normal)
                        self.search.text = ""
                    }
                }
            }
        }else{
            let refreshAlert = UIAlertController(title: "ALERT", message: "You are not loged in. Pleace login", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.navigationController?.popToRootViewController(animated: true)
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            }))
            present(refreshAlert, animated: true, completion: nil)
        }
    }
    @IBAction func popular_Distance_rating_ButtonTapped(_ sender: UIButton) {
        poplular_Distance_RatingButton = sender.currentTitle ?? ""
        if sender.currentTitle == "Popular"{
            if popularStatus == 0{
                popularButton.showColour()
                distanceButton.dontShowColour()
                ratingButton.dontShowColour()
                popularStatus = 1
                distanceStatus = 0
                popRatingStatus = 0
            }else{
                popularButton.dontShowColour()
                popularStatus = 0
            }
        }else if sender.currentTitle == "Distance"{
            if distanceStatus == 0{
                popularButton.dontShowColour()
                distanceButton.showColour()
                ratingButton.dontShowColour()
                popularStatus = 0
                distanceStatus = 1
                popRatingStatus = 0
            }else{
                distanceButton.dontShowColour()
                distanceStatus = 0
            }
        }else if sender.currentTitle == "Rating" {
            if popRatingStatus == 0{
                popularButton.dontShowColour()
                distanceButton.dontShowColour()
                ratingButton.showColour()
                popularStatus = 0
                distanceStatus = 0
                popRatingStatus = 1
            }else{
                ratingButton.dontShowColour()
                popRatingStatus = 0
            }
        }
    }
    
    @IBAction func priceRangeButtonsTapped(_ sender: UIButton) {
        if sender.currentTitle == "₹"{
            if rupeesOneStatus == 0{
                rupeesOne.showColour()
                rupeesTwo.dontShowColour()
                rupeesThree.dontShowColour()
                rupeesFour.dontShowColour()
                rateStatus = 1
                rupeesOneStatus = 1
                rupeesTwoStatus = 0
                rupeesThreeStatus = 0
                rupeesFourStatus = 0
            }else{
                rupeesOne.dontShowColour()
                rateStatus = 0
                rupeesOneStatus = 0
            }
        }else if sender.currentTitle == "₹₹"{
            if rupeesTwoStatus == 0{
                rupeesOne.dontShowColour()
                rupeesTwo.showColour()
                rupeesThree.dontShowColour()
                rupeesFour.dontShowColour()
                rateStatus = 2
                rupeesOneStatus = 0
                rupeesTwoStatus = 1
                rupeesThreeStatus = 0
                rupeesFourStatus = 0
            }else{
                rupeesTwo.dontShowColour()
                rateStatus = 0
                rupeesTwoStatus = 0
            }
        }
        else if sender.currentTitle == "₹₹₹"{
            if rupeesThreeStatus == 0{
                rupeesOne.dontShowColour()
                rupeesTwo.dontShowColour()
                rupeesThree.showColour()
                rupeesFour.dontShowColour()
                rateStatus = 3
                rupeesOneStatus = 0
                rupeesTwoStatus = 0
                rupeesThreeStatus = 1
                rupeesFourStatus = 0
            }else{
                rupeesThree.dontShowColour()
                rateStatus = 0
                rupeesThreeStatus = 0
            }
        }else if sender.currentTitle == "₹₹₹₹"{
            if rupeesFourStatus == 0{
                rupeesOne.dontShowColour()
                rupeesTwo.dontShowColour()
                rupeesThree.dontShowColour()
                rupeesFour.showColour()
                rateStatus = 4
                rupeesOneStatus = 0
                rupeesTwoStatus = 0
                rupeesThreeStatus = 0
                rupeesFourStatus = 1
            }else{
                rupeesFour.dontShowColour()
                rateStatus = 0
                rupeesFourStatus = 0
            }
        }
    }
    
    @IBAction func filterByButton(_ sender: UIButton) {
        if sender.currentTitle == "Accepts creadit card"{
            if acceptCard {
                acceptCardLabel.addChanges()
                cardImage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.26.22 AM")
                acceptCard = false
            }else{
                acceptCardLabel.noChange()
                cardImage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.29.44 AM")
                acceptCard = true
            }
        }else if sender.currentTitle == "Delivary"{
            if delivary {
                delivaryLabel.addChanges()
                delivaryIMage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.26.22 AM")
                delivary = false
            }else{
                delivaryLabel.noChange()
                delivaryIMage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.29.44 AM")
                delivary = true
            }
        }else if sender.currentTitle == "Dog friendly"{
            if dogFriendly  {
                dogFriendlyLabel.addChanges()
                dogFriendlyImage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.26.22 AM")
                dogFriendly = false
            }else{
                dogFriendlyLabel.noChange()
                dogFriendlyImage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.29.44 AM")
                dogFriendly = true
            }
        }else if sender.currentTitle == "Family-friendly place"{
            if familyFriendly  {
                familyFriendlyLabel.addChanges()
                familyFriendlyImage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.26.22 AM")
                familyFriendly = false
            }else{
                familyFriendlyLabel.noChange()
                familyFriendlyImage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.29.44 AM")
                familyFriendly = true
            }
        }else if sender.currentTitle == "In walking distance"{
            if inWalkingDistanceNum  {
                inWalkingDistanceLabel.addChanges()
                inwalkingImage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.26.22 AM")
                inWalkingDistanceNum = false
            }else{
                inWalkingDistanceLabel.noChange()
                inwalkingImage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.29.44 AM")
                inWalkingDistanceNum = true
            }
        }else if sender.currentTitle == "Outdoor seating"{
            if outDoorSeatingNum  {
                outdoorLabel.addChanges()
                outdoorImage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.26.22 AM")
                outDoorSeatingNum = false
            }else{
                outdoorLabel.noChange()
                outdoorImage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.29.44 AM")
                outDoorSeatingNum = true
            }
        }else if sender.currentTitle == "Parking"{
            if parkingNum {
                parkingLabel.addChanges()
                parkingImage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.26.22 AM")
                parkingNum = false
            }else{
                parkingLabel.noChange()
                parkingImage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.29.44 AM")
                parkingNum = true
            }
        }else {
            if wifiNum  {
                wiFiLabel.addChanges()
                wifiimage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.26.22 AM")
                wifiNum = false
            }else{
                wiFiLabel.noChange()
                wifiimage.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.29.44 AM")
                wifiNum = true
            }
        }
    }
    
    @IBAction func useMyCurrentLocationButtonTapped(_ sender: UIButton) {
        let tokenIs = getTheToken.getToken()
        if tokenIs != ""{
            nearYou = 0
            nearMeView.isHidden = true
            tableViewAndViewMap.isHidden = false
            mapAndCollectionView.isHidden = true
            nearYouAndSuggestion.isHidden = true
            filterScreen.isHidden = true
            whiteView.isHidden = true
            objectOfSearchViewModel.search(tokenToSend: tokenIs, latToSend: String(objectOfHomeViewModel.userLocation.last?.latitude ?? "13.379162"), longToSend: String(objectOfHomeViewModel.userLocation.last?.longitude ?? "74.740373"), textToSend: ""){ status in
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
        }else{
            let refreshAlert = UIAlertController(title: "ALERT", message: "You are not loged in. Pleace login", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.navigationController?.popToRootViewController(animated: true)
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            }))
            present(refreshAlert, animated: true, completion: nil)
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
        searching = 0
        filterSearchIs = 0
        test = true
        if sender.currentTitle == "Top pick"{
            callApiForData(endpointToSend: "/getTopPlace")
        }else if sender.currentTitle == "Popular"{
            callApiForData(endpointToSend: "/getPopularPlace")
        }else if sender.currentTitle == "Lunch"{
            callApiForData(endpointToSend: "/getRestaurants")
        }else{
            callApiForData(endpointToSend: "/getCafe")
        }
    }
    
    func callApiForData(endpointToSend: String) {
        let loader =   self.loader()
        objectOfHomeViewModel.apiCallForData(endPoint: endpointToSend, latToSend: String(objectOfHomeViewModel.userLocation.last?.latitude ?? "13.379162"), longToSend: String(objectOfHomeViewModel.userLocation.last?.longitude ?? "74.740373")){ status in
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
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
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
        }else if filterTableToShow == 1{
            return filterElement.capacity
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
            guard let cell = nearMeTableView.dequeueReusableCell(withIdentifier: "cell") as? SearchBodyCell else{ return UITableViewCell()}
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
            cell._Id = objectOfHomeViewModel.homeDetails[indexPath.row]._id
            cell.buttonStatus(id: objectOfHomeViewModel.homeDetails[indexPath.row]._id)
            cell.delegateHomeCell = self
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
            cell._Id = objectOfSearchViewModel.filterSearchDetails[indexPath.row]._id
            cell.buttonStatus(id: objectOfSearchViewModel.filterSearchDetails[indexPath.row]._id)
            cell.setShadow()
            cell.delegateHomeCell = self
            return cell
        } else if filterTableToShow == 1{
            let cell = filterButtonTable.dequeueReusableCell(withIdentifier: "buttonCell") as! FilterButtonTableCell
            cell.selectionStyle = .none
            cell00 = cell
            cell.updateLable.text = filterElement[indexPath.row]
            cell.updateImage.noChanges()
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
        cell._Id = objectOfHomeViewModel.homeDetails[indexPath.row]._id
        cell.buttonStatus(id: objectOfHomeViewModel.homeDetails[indexPath.row]._id)
        cell.setShadow()
        cell.delegateHomeCell = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if nearYou == 1{
            return 55
        }else if filterTableToShow == 1{
            return 42.6
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
            let tokenIs = getTheToken.getToken()
            if tokenIs != ""{
                nearYou = 0
                nearMeView.isHidden = true
                tableViewAndViewMap.isHidden = false
                mapAndCollectionView.isHidden = true
                nearYouAndSuggestion.isHidden = true
                filterScreen.isHidden = true
                whiteView.isHidden = true
                objectOfSearchViewModel.search(tokenToSend: tokenIs, latToSend: String(objectOfHomeViewModel.userLocation.last?.latitude ?? "13.379162"), longToSend: String(objectOfHomeViewModel.userLocation.last?.longitude ?? "74.740373"), textToSend: objectOfSearchViewModel.nearCityData[indexPath.row].cityName){ status in
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
        }else if searching == 1{
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
        }else if filterTableToShow == 1{
            let cell = filterButtonTable.cellForRow(at: indexPath) as! FilterButtonTableCell
            if objectOfSearchViewModel.userFilterChoice.contains(filterElement[indexPath.row]){
                objectOfSearchViewModel.userFilterChoice = objectOfSearchViewModel.userFilterChoice.filter { $0 != filterElement[indexPath.row] }
            }else{
                objectOfSearchViewModel.userFilterChoice.append(filterElement[indexPath.row])
            }
            
            
            
            cell.changeTheStatus(filterItem: filterElement[indexPath.row])
            print("0909",filterElement[indexPath.row])
            
            
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching == 1{
            return objectOfSearchViewModel.searchDetaisl.count
        } else if filterSearchIs == 1{
            return objectOfSearchViewModel.filterSearchDetails.count
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
            annotation.append(["title":objectOfSearchViewModel.searchDetaisl[indexPath.row].placeName,"latitude": objectOfSearchViewModel.searchDetaisl[indexPath.row].latitude,"longitude": objectOfSearchViewModel.searchDetaisl[indexPath.row].longitude])
            setAnnotation(locations: annotation)
            cell._Id = objectOfSearchViewModel.searchDetaisl[indexPath.row]._id
            cell.buttonTatus(id: objectOfSearchViewModel.searchDetaisl[indexPath.row]._id)
            cell.collectionDelegate = self
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
            cell._Id = objectOfSearchViewModel.filterSearchDetails[indexPath.row]._id
            cell.buttonTatus(id: objectOfSearchViewModel.filterSearchDetails[indexPath.row]._id)
            cell.collectionDelegate = self
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
        cell._Id = objectOfHomeViewModel.homeDetails[indexPath.row]._id
        cell.buttonTatus(id: objectOfHomeViewModel.homeDetails[indexPath.row]._id)
        cell.collectionDelegate = self
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
    func tableReloda() {
        map_CollectionView.reloadData()
    }
    
    func reloadTheTable() {
        mapButton_TableView.reloadData()
    }
}
