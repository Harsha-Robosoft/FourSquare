//
//  FavouiretVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 06/01/23.
//

import UIKit
protocol showHomePage1 {
    func homePage1()
}

class FavouiretVc: UIViewController, UITableViewDelegate, UITableViewDataSource, reloadTable{

    

    var objectOfUserDefaults = UserDefaults()
    var objectOfKeyChain = KeyChain()
    var objectOfFavouiretViewModel = FavouiretViewModel.objectOfViewModel
    var objectOfHomeViewModel = HomeViewModel.objectOfViewModel
    
    
    var poplular_Distance_RatingButton = ""
    var rateStatus = 0
    
    var rupeesOneStatus = 0
    var rupeesTwoStatus = 0
    var rupeesThreeStatus = 0
    var rupeesFourStatus = 0
    var popularStatus = 0
    var distanceStatus = 0
    var popRatingStatus = 0
    
    var homeDelegate1: showHomePage1?
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var noDatFoundView: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var favouiretTableView: UITableView!
    @IBOutlet weak var favouiretFilter: UIButton!
    @IBOutlet weak var favouritSearchFielf: UITextField!
    
    
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
    
    var didload = 0
    var filterTapped = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addingPading()
        didload = 1
        noDatFoundView.isHidden = false
        favouiretTableView.isHidden = true
        filterView.isHidden = true
        favouiretTableView.delegate = self
        favouiretTableView.dataSource = self
        favouiretTableView.register(UINib(nibName: "favCell", bundle: nil), forCellReuseIdentifier: "cellFave")
        
        let tokenIs = getToken()
        var dictionaryIs = [String: Any]()
        if didload == 1 {
            var latitudeIs = ""
            var longitudeIs = ""
            if let latitude = objectOfHomeViewModel.userLocation.last?.latitude {
                latitudeIs = latitude
            }
            if let longitude = objectOfHomeViewModel.userLocation.last?.longitude{
                longitudeIs = longitude
            }
            dictionaryIs["latitude"] = latitudeIs
            dictionaryIs["longitude"] = longitudeIs
            dictionaryIs["text"] = ""
        }
        
        
        
        objectOfFavouiretViewModel.userFavouriteplacesListAndSearch(tokenToSend: tokenIs, endpointIs: "/searchFavourite", paramsDictionary: dictionaryIs){ status in
            if status == true{
                self.noDatFoundView.isHidden = true
                self.favouiretTableView.isHidden = false
                self.filterView.isHidden = true
                self.favouiretTableView.reloadData()
            }else{
                self.noDatFoundView.isHidden = false
                self.favouiretTableView.isHidden = true
                self.filterView.isHidden = true
            }
            
        }
                
    }
    
    func reloadTheTable() {
        print("hello ")
        
        let tokenIs = getToken()
        var dictionaryIs = [String: Any]()
        
        var latitudeIs = ""
        var longitudeIs = ""
        if let latitude = objectOfHomeViewModel.userLocation.last?.latitude {
            latitudeIs = latitude
        }
        if let longitude = objectOfHomeViewModel.userLocation.last?.longitude{
            longitudeIs = longitude
        }
        dictionaryIs["latitude"] = latitudeIs
        dictionaryIs["longitude"] = longitudeIs
        dictionaryIs["text"] = ""
        
        
        objectOfFavouiretViewModel.userFavouriteplacesListAndSearch(tokenToSend: tokenIs, endpointIs: "/searchFavourite", paramsDictionary: dictionaryIs){ status in
            if status == true{
                self.noDatFoundView.isHidden = true
                self.favouiretTableView.isHidden = false
                self.filterView.isHidden = true
                self.favouiretTableView.reloadData()
            }else{
                self.noDatFoundView.isHidden = false
                self.favouiretTableView.isHidden = true
                self.filterView.isHidden = true
            }
            
        }
    }
    
    func addingPading() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: favouritSearchFielf.frame.height))
        favouritSearchFielf.leftView = paddingView
        favouritSearchFielf.leftViewMode = .always
    }
    @IBAction func backtapped(_ sender: UIButton) {
        homeDelegate1?.homePage1()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func searchFieldUsing(_ sender: Any) {
        
        if filterTapped != 1{
            
            let tokenIs = getToken()
            var dictionaryIs = [String: Any]()
            if didload == 1 {
                var latitudeIs = ""
                var longitudeIs = ""
                if let latitude = objectOfHomeViewModel.userLocation.last?.latitude {
                    latitudeIs = latitude
                }
                if let longitude = objectOfHomeViewModel.userLocation.last?.longitude{
                    longitudeIs = longitude
                }
                dictionaryIs["latitude"] = latitudeIs
                dictionaryIs["longitude"] = longitudeIs
                dictionaryIs["text"] = searchField.text
            }
            
            objectOfFavouiretViewModel.userFavouriteplacesListAndSearch(tokenToSend: tokenIs, endpointIs: "/searchFavourite", paramsDictionary: dictionaryIs){ status in
                if status == true{
                    self.noDatFoundView.isHidden = true
                    self.favouiretTableView.isHidden = false
                    self.filterView.isHidden = true
                    self.favouiretTableView.reloadData()
                }else{
                    self.noDatFoundView.isHidden = false
                    self.favouiretTableView.isHidden = true
                    self.filterView.isHidden = true
                }
                
            }
        }
  
    }
    
    
    
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        let tokenIs = getToken()
        filterTapped = 1
        if tokenIs != ""{
            
            if sender.currentTitle == nil{
                
                filterView.isHidden = false
                favouiretFilter.setTitle("Done", for: .normal)
                favouiretFilter.setImage(nil, for: .normal)
            }else{
                var latitudeIs = ""
                var longitudeIs = ""
                if let latitude = objectOfHomeViewModel.userLocation.last?.latitude {
                    latitudeIs = latitude
                }
                if let longitude = objectOfHomeViewModel.userLocation.last?.longitude{
                    longitudeIs = longitude
                }
                
                
                var dictionaryIs = [String: Any]()
                dictionaryIs["latitude"] = latitudeIs
                dictionaryIs["longitude"] = longitudeIs
                
                dictionaryIs["text"] = favouritSearchFielf.text
                
                if setRadiousField.text != ""{
                    dictionaryIs["radius"] = setRadiousField.text
                }

                if poplular_Distance_RatingButton != ""{
                    dictionaryIs["sortBy"] = poplular_Distance_RatingButton
                }
                
                if rateStatus != 0{
                    dictionaryIs["price"] = rateStatus
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
                

                objectOfFavouiretViewModel.userFavouriteplacesListAndSearch(tokenToSend: tokenIs, endpointIs: "/favFilter", paramsDictionary: dictionaryIs){ status in
                    if status == true{
                        self.noDatFoundView.isHidden = true
                        self.favouiretTableView.isHidden = false
                        self.filterView.isHidden = true
                        self.favouiretFilter.setTitle(nil, for: .normal)
                        self.favouiretFilter.setImage(#imageLiteral(resourceName: "filter_icon"), for: .normal)
                        self.favouiretTableView.reloadData()
                    }else{
                        self.noDatFoundView.isHidden = false
                        self.favouiretTableView.isHidden = true
                        self.filterView.isHidden = true
                    }
                    
                }

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
                rupeesOneStatus = 0
                rateStatus = 0
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
                rupeesTwoStatus = 0
                rateStatus = 0
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
                rupeesThreeStatus = 0
                rateStatus = 0
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
                rupeesFourStatus = 0
                rateStatus = 0
            }
            
            
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
                popularStatus = 0
                popularButton.dontShowColour()
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
                distanceStatus = 0
                distanceButton.dontShowColour()
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
                popRatingStatus = 0
                ratingButton.dontShowColour()
            }
            
            
        }
        
    }
}

extension FavouiretVc{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectOfFavouiretViewModel.favSearchDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favouiretTableView.dequeueReusableCell(withIdentifier: "cellFave") as! FavTableCell
        var imageIs = objectOfFavouiretViewModel.favSearchDetails[indexPath.row].placeImage
        imageIs.insert("s", at: imageIs.index(imageIs.startIndex, offsetBy: 4))
        cell.imageIs.image = getImage(urlString: imageIs)
        cell.addresIs.text = "\(objectOfFavouiretViewModel.favSearchDetails[indexPath.row].address),\(objectOfFavouiretViewModel.favSearchDetails[indexPath.row].city)"
        cell.distanceIs.text = "\(objectOfFavouiretViewModel.favSearchDetails[indexPath.row].distance)km"
        cell.nameIs.text = objectOfFavouiretViewModel.favSearchDetails[indexPath.row].placeName
        cell.nationalityIs.text = objectOfFavouiretViewModel.favSearchDetails[indexPath.row].category
        cell.ratingIs.text = objectOfFavouiretViewModel.favSearchDetails[indexPath.row].rating
        if objectOfFavouiretViewModel.favSearchDetails[indexPath.row].priceRange == "1"{
            cell.rateIs.text = "₹"
        }else if objectOfFavouiretViewModel.favSearchDetails[indexPath.row].priceRange == "2"{
            cell.rateIs.text = "₹₹"
        }else if objectOfFavouiretViewModel.favSearchDetails[indexPath.row].priceRange == "3"{
            cell.rateIs.text = "₹₹₹"
        }else if objectOfFavouiretViewModel.favSearchDetails[indexPath.row].priceRange == "4"{
            cell.rateIs.text = "₹₹₹₹"
        }else if objectOfFavouiretViewModel.favSearchDetails[indexPath.row].priceRange == "5"{
            cell.rateIs.text = "₹₹₹₹₹"
        }
        
        print("koli : \(objectOfFavouiretViewModel.favSearchDetails[indexPath.row]._id)")
        
        cell.placeId = objectOfFavouiretViewModel.favSearchDetails[indexPath.row]._id
        cell.delegateCell = self
        cell.setShadow()
        return cell
    }
}

extension FavouiretVc{
    
    func getToken() -> String {
        var id = ""
       let userIdIs = objectOfUserDefaults.value(forKey: "userId")
        if let idIs = userIdIs as? String{
            id = idIs
        }
        print("Favourite id : \(id)")
        guard let receivedTokenData = objectOfKeyChain.loadData(userId: id) else {print("utr 2")
            return ""}
        guard let receivedToken = String(data: receivedTokenData, encoding: .utf8) else {print("utr 3")
            return ""}
        print("Favourite token",receivedToken)
        return receivedToken
    }
}
