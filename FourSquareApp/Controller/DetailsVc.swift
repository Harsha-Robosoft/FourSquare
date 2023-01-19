//
//  DetailsVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 07/01/23.
//

import UIKit
import MapKit
import CoreLocation

class DetailsVc: UIViewController, CLLocationManagerDelegate {
    
    var objectOfAddToFavouiretViewModel = AddToFavoriteViewModel.objectOfAddToFavoriteViewModel
    var objectOfHomeViewModel = HomeViewModel.objectOfViewModel
    var objectOfPlaceDetailsViewModel = PlaceDetailsViewModel.objectOfviewModel
    var getTheToken = GetToken.getTheUserToken
    var manager = CLLocationManager()
    
    var placeName = ""
    var placeId = ""
    var givenRating = 0
    var ratingISIS = 0.0
    
    @IBOutlet weak var starOne: DetailsStarsStatus!
    @IBOutlet weak var starTwo: DetailsStarsStatus!
    @IBOutlet weak var starThree: DetailsStarsStatus!
    @IBOutlet weak var starfour: DetailsStarsStatus!
    @IBOutlet weak var starFive: DetailsStarsStatus!
    
    @IBOutlet weak var ratingBackView: UIView!
    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var ratingStarOne: DetailsStarsStatus!
    @IBOutlet weak var ratingStarTwo: DetailsStarsStatus!
    @IBOutlet weak var ratingStarThree: DetailsStarsStatus!
    @IBOutlet weak var ratingStarFour: DetailsStarsStatus!
    @IBOutlet weak var ratingStarFive: DetailsStarsStatus!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var cetegoryIs: UILabel!
    @IBOutlet weak var mapIs: MKMapView!
    @IBOutlet weak var imageToshow: UIImageView!
    @IBOutlet weak var nameToShow: UILabel!
    @IBOutlet weak var starLikeBuyyon: UIButton!
    @IBOutlet weak var overViewToShow: UILabel!
    
    @IBOutlet weak var adressToshow: UILabel!
    @IBOutlet weak var numberToShow: UILabel!
    @IBOutlet weak var distanceToShow: UILabel!
    
    @IBOutlet weak var topView: GradientTop!
    @IBOutlet weak var bottomView: GradientBottom!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ratingBackView.isHidden = true
        ratingView.isHidden = true
        objectOfPlaceDetailsViewModel.perticularPlaceDetailsApiCall(placeId: placeId){ status in
            if status == true{
                self.didLoadFunction()
            }else{}
        }
    }

    func didLoadFunction() {
        var latTOsend = 0.0
        var longTosend = 0.0
        var imageIs = ""
        var name = ""
        var overView = ""
        var address = ""
        var cityname = ""
        var numberIs = ""
        var categotyIs = ""
        var ratingIs = 0.0
        var placeIdIs = ""
        if let lat = self.objectOfPlaceDetailsViewModel.perticularPlaceDetails.last?.latitude{
            latTOsend = lat
        }
        if let long = self.objectOfPlaceDetailsViewModel.perticularPlaceDetails.last?.longitude{
            longTosend = long
        }
        if let nameIs = self.objectOfPlaceDetailsViewModel.perticularPlaceDetails.last?.placeName {
            self.placeName = nameIs
            name = nameIs
        }
        if let over = self.objectOfPlaceDetailsViewModel.perticularPlaceDetails.last?.overview {
            overView = over
        }
        if let addressIs = self.objectOfPlaceDetailsViewModel.perticularPlaceDetails.last?.address {
            address = addressIs
        }
        if let city = self.objectOfPlaceDetailsViewModel.perticularPlaceDetails.last?.city {
            cityname = city
        }
        if let num = self.objectOfPlaceDetailsViewModel.perticularPlaceDetails.last?.phoneNumber {
            numberIs = num
        }
        if let cate = self.objectOfPlaceDetailsViewModel.perticularPlaceDetails.last?.category {
            categotyIs = cate
        }
        if let rating = self.objectOfPlaceDetailsViewModel.perticularPlaceDetails.last?.rating{
            self.ratingISIS = rating
            ratingIs = Double(rating)
        }
        if let placeId = self.objectOfPlaceDetailsViewModel.perticularPlaceDetails.last?.placeId{
            placeIdIs = placeId
        }
        if let image00 = self.objectOfPlaceDetailsViewModel.perticularPlaceDetails.last?.placeImage{
            imageIs = image00
        }
        imageIs.insert("s", at: imageIs.index(imageIs.startIndex, offsetBy: 4))
        numberIs.insert(" ", at: numberIs.index(numberIs.startIndex, offsetBy: 5))
        
        if self.objectOfHomeViewModel.userFavouiretListArray.contains(placeIdIs){
            self.starLikeBuyyon.setImage(#imageLiteral(resourceName: "rating_icon_selected"), for: .normal)
        }else{
            self.starLikeBuyyon.setImage(#imageLiteral(resourceName: "rating_icon_unselected"), for: .normal)
        }
        
        if ratingIs == 1{
            self.starOne.changes()
            self.starTwo.noChange()
            self.starThree.noChange()
            self.starfour.noChange()
            self.starFive.noChange()
        }else if ratingIs == 2{
            self.starOne.changes()
            self.starTwo.changes()
            self.starThree.noChange()
            self.starfour.noChange()
            self.starFive.noChange()
        }
        else if ratingIs == 3{
            self.starOne.changes()
            self.starTwo.changes()
            self.starThree.changes()
            self.starfour.noChange()
            self.starFive.noChange()
        }
        else if ratingIs == 4{
            self.starOne.changes()
            self.starTwo.changes()
            self.starThree.changes()
            self.starfour.changes()
            self.starFive.noChange()
        }
        else if ratingIs == 5{
            self.starOne.changes()
            self.starTwo.changes()
            self.starThree.changes()
            self.starfour.changes()
            self.starFive.changes()
        }
        self.cetegoryIs.text = categotyIs.capitalized
        self.render(latitude: latTOsend, longitude: longTosend)
        self.imageToshow.image = self.getImage(urlString: imageIs)
        self.nameToShow.text = name.capitalized
        self.overViewToShow.text = overView
        self.numberToShow.text = "+91 \(numberIs)"
        self.adressToshow.text = "\(address),\(cityname)."
    }
    func render(latitude: Double, longitude: Double) {
        
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapIs.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapIs.addAnnotation(pin)
    }
    @IBAction func ratingScreenCancelButton(_ sender: UIButton) {
        ratingBackView.isHidden = true
        ratingView.isHidden = true
    }
    
    
    @IBAction func ratingSubmitButtonTapped(_ sender: UIButton) {
        let call = getTheToken.getToken()
        if call != ""{
            objectOfPlaceDetailsViewModel.addRatingApiCall(tokenTosend: call, placeId: placeId, ratingToSend: givenRating){status in
                if status == true{
                    self.ratingBackView.isHidden = true
                    self.ratingView.isHidden = true
                }else{ }
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
    
    @IBAction func ratingStarTapped(_ sender: UIButton) {
        if sender.currentTitle == "one"{
            ratingStarOne.changes()
            ratingStarTwo.noChange()
            ratingStarThree.noChange()
            ratingStarFour.noChange()
            ratingStarFive.noChange()
            givenRating = 1
        }else if sender.currentTitle == "two"{
            ratingStarOne.changes()
            ratingStarTwo.changes()
            ratingStarThree.noChange()
            ratingStarFour.noChange()
            ratingStarFive.noChange()
            givenRating = 2
        }else if sender.currentTitle == "three"{
            ratingStarOne.changes()
            ratingStarTwo.changes()
            ratingStarThree.changes()
            ratingStarFour.noChange()
            ratingStarFive.noChange()
            givenRating = 3
        }else if sender.currentTitle == "four"{
            ratingStarOne.changes()
            ratingStarTwo.changes()
            ratingStarThree.changes()
            ratingStarFour.changes()
            ratingStarFive.noChange()
            givenRating = 4
        }else if sender.currentTitle == "five"{
            ratingStarOne.changes()
            ratingStarTwo.changes()
            ratingStarThree.changes()
            ratingStarFour.changes()
            ratingStarFive.changes()
            givenRating = 5
        }
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addReviewButtonTapped(_ sender: UIButton) {
        let addReviewVc = self.storyboard?.instantiateViewController(withIdentifier: "AddReviewVc") as? AddReviewVc
        if let vc = addReviewVc{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @IBAction func ratingButtonTapped(_ sender: UIButton) {
        ratingBackView.isHidden = false
        ratingView.isHidden = false
        
        let blur = UIBlurEffect(style: .regular)
        let effectView = UIVisualEffectView(effect: blur)
        effectView.frame = ratingBackView.bounds
        effectView.alpha = 1
        ratingBackView.addSubview( effectView)
        
        let number = ratingISIS
        let roundedNumber = String(format: "%.1f", number)
        ratingLabel.text = roundedNumber
    }
    
    @IBAction func photosButtonTapped(_ sender: UIButton) {
        let photoVc = self.storyboard?.instantiateViewController(withIdentifier: "PhotoVc") as? PhotoVc
        if let vc = photoVc{
            vc.placeId = placeId
            vc.nameIs = placeName
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func reviewBbuttonTapped(_ sender: UIButton) {
        let reviewVc = self.storyboard?.instantiateViewController(withIdentifier: "ReviewVc") as? ReviewVc
        if let vc = reviewVc{
            vc.placeId = placeId
            vc.nameIs = placeName
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        let call = getTheToken.getToken()
        if call != ""{
            if sender.currentImage == #imageLiteral(resourceName: "rating_icon_selected"){
                objectOfAddToFavouiretViewModel.addPlaceToFavouiretList(tokenTosend: call, placeIdToSend: placeId){ status in
                    if status == true{
                        self.objectOfHomeViewModel.userFavouiretListArray = self.objectOfHomeViewModel.userFavouiretListArray.filter { $0 != self.placeId}
                        self.starLikeBuyyon.setImage(#imageLiteral(resourceName: "rating_icon_unselected"), for: .normal)
                        self.objectOfHomeViewModel.AllFavouiretPlaceIdApiCall(tokenTosend: call){ status in
                            if status == true{
                                print("fav id list received")
                            }else{
                                print("fav id list NOT received")
                            }
                        }
                    }else{}
                }
            }else{
                objectOfAddToFavouiretViewModel.addPlaceToFavouiretList(tokenTosend: call, placeIdToSend: placeId){ status in
                    if status == true{
                        self.starLikeBuyyon.setImage(#imageLiteral(resourceName: "rating_icon_selected"), for: .normal)
                        self.objectOfHomeViewModel.userFavouiretListArray.append(self.placeId)
                        self.objectOfHomeViewModel.userFavouiretListArray.append(self.placeId)
                        self.objectOfHomeViewModel.AllFavouiretPlaceIdApiCall(tokenTosend: call){ status in
                            if status == true{
                                print("fav id list received")
                            }else{
                                print("fav id list NOT received")
                            }
                        }
                    }else{}
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
}

