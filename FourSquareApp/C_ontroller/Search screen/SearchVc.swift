//
//  SearchVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 03/01/23.
//

import UIKit
import MapKit
import CoreLocation

class SearchVc: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var search: UITextField!
    @IBOutlet weak var nearMe: UITextField!
    
//    views ------------------------------------
    @IBOutlet weak var nearMeView: UIView!
    @IBOutlet weak var tableViewAndViewMap: UIView!
    @IBOutlet weak var mapAndCollectionView: UIView!
    @IBOutlet weak var nearYouAndSuggestion: UIView!
    @IBOutlet weak var filterScreen: UIView!
    @IBOutlet weak var whiteView: UIView!
   
//    filter screen fields -------------------------------------------
    
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
    
//    map & collection view fields ----------------------------------------
    
    @IBOutlet weak var mapAndColectionView: MKMapView!
    @IBOutlet weak var listViewButton: UIButton!
    @IBOutlet weak var map_CollectionView: UICollectionView!

//    near me view fields ----------------------------
    @IBOutlet weak var useMyCurrentLocationButton: UIButton!
    
    @IBOutlet weak var searchBymap: UIButton!
    
    
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if let name = textField.placeholder {
            
            if name == "Search"{
                
                nearMeView.isHidden = true
                tableViewAndViewMap.isHidden = true
                mapAndCollectionView.isHidden = true
                nearYouAndSuggestion.isHidden = false
                filterScreen.isHidden = true
                whiteView.isHidden = true
                
            }else{
                
                nearMeView.isHidden = false
                tableViewAndViewMap.isHidden = true
                mapAndCollectionView.isHidden = true
                nearYouAndSuggestion.isHidden = true
                filterScreen.isHidden = true
                whiteView.isHidden = true
                
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
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func filterButtonTapped(_ sender: Any) {
        
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
        
        nearMeView.isHidden = true
        tableViewAndViewMap.isHidden = false
        mapAndCollectionView.isHidden = true
        nearYouAndSuggestion.isHidden = true
        filterScreen.isHidden = true
        whiteView.isHidden = true
        
        
    }
    
    @IBAction func searchInMapButtonTapped(_ sender: UIButton) {
        
        nearMeView.isHidden = true
        tableViewAndViewMap.isHidden = true
        mapAndCollectionView.isHidden = false
        nearYouAndSuggestion.isHidden = true
        filterScreen.isHidden = true
        whiteView.isHidden = true
        map_CollectionView.isHidden = true
        listViewButton.isHidden = true
        
        
    }
    
    
}

extension SearchVc{
    
    
    
}
