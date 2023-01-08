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

    var objectOfPlaceDetailsViewModel = PlaceDetailsViewModel.objectOfviewModel
    
    var placeId = ""
    
    
    
    var manager = CLLocationManager()
    
    @IBOutlet weak var starOne: DetailsStarsStatus!
    @IBOutlet weak var starTwo: DetailsStarsStatus!
    @IBOutlet weak var starThree: DetailsStarsStatus!
    @IBOutlet weak var starfour: DetailsStarsStatus!
    @IBOutlet weak var starFive: DetailsStarsStatus!
    
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
        
        objectOfPlaceDetailsViewModel.perticularPlaceDetailsApiCall(placeId: placeId){ status in
            if status == true{
                var latTOsend = 0.0
                var longTosend = 0.0
                var imageIs = ""
                var name = ""
                var overView = ""
                var address = ""
                var cityname = ""
                var numberIs = ""
                var categotyIs = ""
                var ratingIs = 0
                if let lat = self.objectOfPlaceDetailsViewModel.perticularPlaceDetails.last?.latitude{
                    latTOsend = lat
                }
                if let long = self.objectOfPlaceDetailsViewModel.perticularPlaceDetails.last?.longitude{
                    longTosend = long
                }
                if let nameIs = self.objectOfPlaceDetailsViewModel.perticularPlaceDetails.last?.placeName {
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
                    ratingIs = Int(rating)
                }
                
                
                if let image00 = self.objectOfPlaceDetailsViewModel.perticularPlaceDetails.last?.placeImage{
                    imageIs = image00
                }
                imageIs.insert("s", at: imageIs.index(imageIs.startIndex, offsetBy: 4))
                
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
                
                
            }else{
                
            }
            
        }

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
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    


}
