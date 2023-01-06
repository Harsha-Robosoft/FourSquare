//
//  FavouiretVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 06/01/23.
//

import UIKit

class FavouiretVc: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var objectOfUserDefaults = UserDefaults()
    var objectOfKeyChain = KeyChain()
    
    var poplular_Distance_RatingButton = ""
    var rateStatus = ""
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addingPading()
        filterView.isHidden = true
        favouiretTableView.delegate = self
        favouiretTableView.dataSource = self
        favouiretTableView.register(UINib(nibName: "mapFile", bundle: nil), forCellReuseIdentifier: "cell")
        
        // Do any additional setup after loading the view.
    }
    
    func addingPading() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: favouritSearchFielf.frame.height))
        favouritSearchFielf.leftView = paddingView
        favouritSearchFielf.leftViewMode = .always
    }
    @IBAction func backtapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        let tokenIs = getToken()
        
        if tokenIs != ""{
            
            if sender.currentTitle == nil{
                
                filterView.isHidden = false
                favouiretFilter.setTitle("Done", for: .normal)
                favouiretFilter.setImage(nil, for: .normal)
            }else{
                
                var dictionaryIs = [String: Any]()
                dictionaryIs["latitude"] = "13.379162"
                dictionaryIs["longitude"] = "74.740373"
                
//                print("search name : \(search.text)")
                
                if favouritSearchFielf.text != ""{
                    dictionaryIs["text"] = favouritSearchFielf.text
                }
                
                if setRadiousField.text != ""{
                    dictionaryIs["radius"] = setRadiousField.text
                }

                if poplular_Distance_RatingButton != ""{
                    dictionaryIs["sortBy"] = poplular_Distance_RatingButton
                }
                
//                if rateStatus != ""{
//                    dicIs["text"] = search.text
//                }
                if acceptCard == false{
                    dictionaryIs["acceptedCredit"] = true
//                    print("card accepted")
                }
                if delivary == false{
                    dictionaryIs["delivery"] = true
//                    print("Delivary is there")
                }
                if dogFriendly == false{
                    dictionaryIs["dogFriendly"] = true
//                    print("Dog friendly")
                }
                if familyFriendly == false{
                    dictionaryIs["familyFriendly"] = true
//                    print("famili friendly")
                }
                if inWalkingDistanceNum == false{
                    dictionaryIs["inWalkingDistance"] = true
//                    print("in walking distance")
                }
                if outDoorSeatingNum == false{
                    dictionaryIs["outdoorDining"] = true
//                    print("out door seating is there")
                }
                if parkingNum == false{
                    dictionaryIs["parking"] = true
//                    print("parking in there")
                }
                if wifiNum == false{
                    dictionaryIs["wifi"] = true
//                   print("wifi is there")
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
        
        rateStatus = sender.currentTitle ?? ""
        
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
}

extension FavouiretVc{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favouiretTableView.dequeueReusableCell(withIdentifier: "cell") as! HomeTableViewCell
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
