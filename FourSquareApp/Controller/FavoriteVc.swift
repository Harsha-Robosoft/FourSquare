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

class FavoritetVc: UIViewController, UITableViewDelegate, UITableViewDataSource, reloadTable{
    
    var searchViewModel_shared = SearchViewModel._shared
    var getTheToken_shared = GetToken._shared
    var favouiretViewModel_shared = FavoriteViewModel._shared
    var homeViewModel_shared = HomeViewModel._shared
    
    var poplular_Distance_RatingButton = ""
    var rateStatus = 0
    
    var rupeesOneStatus = 0
    var rupeesTwoStatus = 0
    var rupeesThreeStatus = 0
    var rupeesFourStatus = 0
    var popularStatus = 0
    var distanceStatus = 0
    var popRatingStatus = 0
    
    var filterElement = ["Accepts creadit card","Delivary","Dog friendly","Family-friendly place","In walking distance","Outdoor seating","Parking","Wi-fi"]
    var homeDelegate1: showHomePage1?
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var noDatFoundView: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var favouiretTableView: UITableView!
    @IBOutlet weak var favouiretFilter: UIButton!
    @IBOutlet weak var favouritSearchFielf: UITextField!
    
    @IBOutlet weak var filterButtonTable: UITableView!
    @IBOutlet weak var popularButton: SearchScreenButton!
    @IBOutlet weak var distanceButton: SearchScreenButton!
    @IBOutlet weak var ratingButton: SearchScreenButton!
    @IBOutlet weak var setRadiousField: TextFieldBorder!
    @IBOutlet weak var rupeesOne: SearchScreenButton!
    @IBOutlet weak var rupeesTwo: SearchScreenButton!
    @IBOutlet weak var rupeesThree: SearchScreenButton!
    @IBOutlet weak var rupeesFour: SearchScreenButton!
    
    var didload = 0
    var filterTapped = 0
    var filterTableToShow = 0
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
        
        
        let tokenIs = getTheToken_shared.getToken()
        
        if tokenIs != ""{
            var dictionaryIs = [String: Any]()
            if didload == 1 {
                var latitudeIs = ""
                var longitudeIs = ""
                if let latitude = homeViewModel_shared.userLocation.last?.latitude {
                    latitudeIs = latitude
                }
                if let longitude = homeViewModel_shared.userLocation.last?.longitude{
                    longitudeIs = longitude
                }
                dictionaryIs["latitude"] = latitudeIs
                dictionaryIs["longitude"] = longitudeIs
                dictionaryIs["text"] = ""
            }
            
            
            
            favouiretViewModel_shared.userFavouriteplacesListAndSearch(tokenToSend: tokenIs, endpointToSend: "/searchFavourite", paramsDictionary: dictionaryIs){ status in
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
        }else{
            let refreshAlert = UIAlertController(title: "ALERT", message: "You are not loged in. Pleace login", preferredStyle: UIAlertController.Style.alert)
            
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
    
    func reloadTheTable() {
        
        let tokenIs = getTheToken_shared.getToken()
        var dictionaryIs = [String: Any]()
        
        var latitudeIs = ""
        var longitudeIs = ""
        if let latitude = homeViewModel_shared.userLocation.last?.latitude {
            latitudeIs = latitude
        }
        if let longitude = homeViewModel_shared.userLocation.last?.longitude{
            longitudeIs = longitude
        }
        dictionaryIs["latitude"] = latitudeIs
        dictionaryIs["longitude"] = longitudeIs
        dictionaryIs["text"] = ""
        
        
        favouiretViewModel_shared.userFavouriteplacesListAndSearch(tokenToSend: tokenIs, endpointToSend: "/searchFavourite", paramsDictionary: dictionaryIs){ status in
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
        searchViewModel_shared.userFilterChoice.removeAll()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func searchFieldUsing(_ sender: Any) {
        
        if filterTapped != 1{
            
            let tokenIs = getTheToken_shared.getToken()
            var dictionaryIs = [String: Any]()
            if didload == 1 {
                var latitudeIs = ""
                var longitudeIs = ""
                if let latitude = homeViewModel_shared.userLocation.last?.latitude {
                    latitudeIs = latitude
                }
                if let longitude = homeViewModel_shared.userLocation.last?.longitude{
                    longitudeIs = longitude
                }
                dictionaryIs["latitude"] = latitudeIs
                dictionaryIs["longitude"] = longitudeIs
                dictionaryIs["text"] = searchField.text
            }
            
            favouiretViewModel_shared.userFavouriteplacesListAndSearch(tokenToSend: tokenIs, endpointToSend: "/searchFavourite", paramsDictionary: dictionaryIs){ status in
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
        let tokenIs = getTheToken_shared.getToken()
        filterTapped = 1
        filterTableToShow = 1
        filterButtonTable.delegate = self
        filterButtonTable.dataSource = self
        filterButtonTable.reloadData()
        if tokenIs != ""{
            
            if sender.currentTitle == nil{
                
                filterView.isHidden = false
                favouiretFilter.setTitle("Done", for: .normal)
                favouiretFilter.setImage(nil, for: .normal)
            }else{
                var latitudeIs = ""
                var longitudeIs = ""
                if let latitude = homeViewModel_shared.userLocation.last?.latitude {
                    latitudeIs = latitude
                }
                if let longitude = homeViewModel_shared.userLocation.last?.longitude{
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
                if searchViewModel_shared.userFilterChoice.contains("Accepts creadit card"){
                    dictionaryIs["acceptedCredit"] = true
                }
                if searchViewModel_shared.userFilterChoice.contains("Delivary"){
                    dictionaryIs["delivery"] = true
                }
                if searchViewModel_shared.userFilterChoice.contains("Dog friendly"){
                    dictionaryIs["dogFriendly"] = true
                }
                if searchViewModel_shared.userFilterChoice.contains("Family-friendly place"){
                    dictionaryIs["familyFriendly"] = true
                }
                if searchViewModel_shared.userFilterChoice.contains("In walking distance"){
                    dictionaryIs["inWalkingDistance"] = true
                }
                if searchViewModel_shared.userFilterChoice.contains("Outdoor seating"){
                    dictionaryIs["outdoorDining"] = true
                }
                if searchViewModel_shared.userFilterChoice.contains("Parking"){
                    dictionaryIs["parking"] = true
                }
                if searchViewModel_shared.userFilterChoice.contains("Wi-fi"){
                    dictionaryIs["wifi"] = true
                }
                
            print("dictionary is : \(dictionaryIs)")
                
                favouiretViewModel_shared.userFavouriteplacesListAndSearch(tokenToSend: tokenIs, endpointToSend: "/favFilter", paramsDictionary: dictionaryIs){ [self] status in
                    DispatchQueue.main.async {
                        if status == true{
                            filterTableToShow = 0
                            noDatFoundView.isHidden = true
                            favouiretTableView.isHidden = false
                            filterView.isHidden = true
                            favouiretFilter.setTitle(nil, for: .normal)
                            favouiretFilter.setImage(#imageLiteral(resourceName: "filter_icon"), for: .normal)
                            favouiretTableView.reloadData()
                            searchField.text = ""
                            searchViewModel_shared.userFilterChoice.removeAll()

                        }else{
                            noDatFoundView.isHidden = false
                            favouiretTableView.isHidden = true
                            filterView.isHidden = true
                            favouiretFilter.setTitle(nil, for: .normal)
                            favouiretFilter.setImage(#imageLiteral(resourceName: "filter_icon"), for: .normal)
                            searchField.text = ""
                            searchViewModel_shared.userFilterChoice.removeAll()

                        }
                    }
                }
                
            }
            
        }else{
            let refreshAlert = UIAlertController(title: "ALERT", message: "You are not loged in. Pleace login", preferredStyle: UIAlertController.Style.alert)
            
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

extension FavoritetVc{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         if filterTableToShow == 1{
            return 42.6
        }
        return 135
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filterTableToShow == 1{
            return filterElement.count
        }
        return favouiretViewModel_shared.favSearchDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if filterTableToShow == 1{
            let cell = filterButtonTable.dequeueReusableCell(withIdentifier: "buttonCell") as! FilterButtonTableCell
            cell.selectionStyle = .none
            cell.updateLable.text = filterElement[indexPath.row]
            cell.updateImage.noChanges()
            cell.updateLable.noChanges()
            return cell
        }
        
        let cell = favouiretTableView.dequeueReusableCell(withIdentifier: "cellFave") as! FavTableCell
        var imageIs = favouiretViewModel_shared.favSearchDetails[indexPath.row].placeImage
        imageIs.insert("s", at: imageIs.index(imageIs.startIndex, offsetBy: 4))
        cell.imageIs.image = getImage(urlString: imageIs)
        cell.addresIs.text = "\(favouiretViewModel_shared.favSearchDetails[indexPath.row].address),\(favouiretViewModel_shared.favSearchDetails[indexPath.row].city)"
        cell.distanceIs.text = "\(favouiretViewModel_shared.favSearchDetails[indexPath.row].distance)km"
        cell.nameIs.text = favouiretViewModel_shared.favSearchDetails[indexPath.row].placeName
        cell.nationalityIs.text = favouiretViewModel_shared.favSearchDetails[indexPath.row].category
        cell.ratingIs.text = favouiretViewModel_shared.favSearchDetails[indexPath.row].rating
        if favouiretViewModel_shared.favSearchDetails[indexPath.row].priceRange == "1"{
            cell.rateIs.text = "₹"
        }else if favouiretViewModel_shared.favSearchDetails[indexPath.row].priceRange == "2"{
            cell.rateIs.text = "₹₹"
        }else if favouiretViewModel_shared.favSearchDetails[indexPath.row].priceRange == "3"{
            cell.rateIs.text = "₹₹₹"
        }else if favouiretViewModel_shared.favSearchDetails[indexPath.row].priceRange == "4"{
            cell.rateIs.text = "₹₹₹₹"
        }else if favouiretViewModel_shared.favSearchDetails[indexPath.row].priceRange == "5"{
            cell.rateIs.text = "₹₹₹₹₹"
        }
        cell.placeId = favouiretViewModel_shared.favSearchDetails[indexPath.row]._id
        cell.delegateCell = self
        cell.setShadow()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if filterTableToShow == 1{
            let cell = filterButtonTable.cellForRow(at: indexPath) as! FilterButtonTableCell
            if searchViewModel_shared.userFilterChoice.contains(filterElement[indexPath.row]){
                searchViewModel_shared.userFilterChoice = searchViewModel_shared.userFilterChoice.filter { $0 != filterElement[indexPath.row] }
            }else{
                searchViewModel_shared.userFilterChoice.append(filterElement[indexPath.row])
            }
            cell.changeTheStatus(filterItem: filterElement[indexPath.row])
            print("0909",filterElement[indexPath.row])
            
        }
    }
}

