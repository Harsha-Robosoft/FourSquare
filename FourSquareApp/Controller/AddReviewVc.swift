//
//  AddReviewVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 08/01/23.
//

import UIKit

class AddReviewVc: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    
    @IBOutlet weak var addYourPhots: UILabel!
    @IBOutlet weak var reviewFieldHeight: NSLayoutConstraint!
    @IBOutlet weak var writereviewHeight: NSLayoutConstraint!
    @IBOutlet weak var addRevie_AddPhotoFiewld: UILabel!
    var addonlyPhoto = 0
    
    var objectOfReviewViewModel = ReviewViewModel.objectOfViewModel
    var getTheToken = GetToken.getTheUserToken

    var placeIsIs = ""
    var photoArray = [UIImage]()
    
    @IBOutlet weak var reviewField: FeedbackFieldBackgroundColour!
    
    @IBOutlet weak var view_1: UIView!
    @IBOutlet weak var view_2: UIView!
    @IBOutlet weak var view_3: UIView!
    @IBOutlet weak var view_4: UIView!
    @IBOutlet weak var view_5: UIView!
    
    @IBOutlet weak var image_1: UIImageView!
    @IBOutlet weak var image_2: UIImageView!
    @IBOutlet weak var image_3: UIImageView!
    @IBOutlet weak var image_4: UIImageView!
    @IBOutlet weak var image_5: UIImageView!
    
    @IBOutlet weak var button_1: UIButton!
    @IBOutlet weak var button_2: UIButton!
    @IBOutlet weak var button_3: UIButton!
    @IBOutlet weak var button_4: UIButton!
    @IBOutlet weak var button_5: UIButton!

    @IBOutlet weak var submitButton: UIButton!
    
    var buttonw1 = 1
    var buttonw2 = 0
    var buttonw3 = 0
    var buttonw4 = 0
    var buttonw5 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if addonlyPhoto == 0{
            reviewFieldHeight.constant = 200
            writereviewHeight.constant = 33
            submitButton.isEnabled = false
            submitButton.alpha = 0.5
            view_2.isHidden = true
            view_3.isHidden = true
            view_4.isHidden = true
            view_5.isHidden = true
        }else{
            
            addRevie_AddPhotoFiewld.text = "Add photos"
            addYourPhots.text = "Add your photos"
            reviewFieldHeight.constant = 0
            writereviewHeight.constant = 0
            submitButton.isEnabled = false
            submitButton.alpha = 0.5
            view_2.isHidden = true
            view_3.isHidden = true
            view_4.isHidden = true
            view_5.isHidden = true
        }
        
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
        addonlyPhoto = 0
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func button_1Tapped(_ sender: UIButton) {
        imagePickerFunction()
    }
    @IBAction func button_2Tapped(_ sender: UIButton) {
        imagePickerFunction()
    }
    @IBAction func button_3Tapped(_ sender: UIButton) {
        imagePickerFunction()
    }
    @IBAction func button_4Tapped(_ sender: UIButton) {
        imagePickerFunction()
    }
    @IBAction func button_5Tapped(_ sender: UIButton) {
        imagePickerFunction()
    }
    
    func imagePickerFunction() {
        let imageController = UIImagePickerController()
        imageController.delegate = self
        imageController.sourceType = .photoLibrary
        self.present(imageController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if buttonw1 == 1{
            image_1.image = info[.originalImage] as? UIImage
            photoArray.append(image_1.image ?? #imageLiteral(resourceName: "Ferrari-1200-1-1024x683"))
            button_1.isHidden = true
            view_2.isHidden = false
            buttonw1 = 0
            buttonw2 = 1
            submitButton.isEnabled = true
            submitButton.alpha = 1.0
        }else if buttonw2 == 1{
            image_2.image = info[.originalImage] as? UIImage
            photoArray.append(image_2.image ?? #imageLiteral(resourceName: "Ferrari-1200-1-1024x683"))
            button_2.isHidden = true
            view_3.isHidden = false
            buttonw2 = 0
            buttonw3 = 1
        }else if buttonw3 == 1{
            image_3.image = info[.originalImage] as? UIImage
            photoArray.append(image_3.image ?? #imageLiteral(resourceName: "Ferrari-1200-1-1024x683"))
            button_3.isHidden = true
            view_4.isHidden = false
            buttonw3 = 0
            buttonw4 = 1
        }else if buttonw4 == 1{
            image_4.image = info[.originalImage] as? UIImage
            photoArray.append(image_4.image ?? #imageLiteral(resourceName: "Ferrari-1200-1-1024x683"))
            button_4.isHidden = true
            view_5.isHidden = false
            buttonw4 = 0
            buttonw5 = 1
        }else if buttonw5 == 1{
            image_5.image = info[.originalImage] as? UIImage
            photoArray.append(image_5.image ?? #imageLiteral(resourceName: "Ferrari-1200-1-1024x683"))
            button_5.isHidden = true
            buttonw5 = 0
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func reviewTextField(_ sender: Any) {
        
        if reviewField.text != ""{
            submitButton.isEnabled = true
            submitButton.alpha = 1.0
        }else{
            submitButton.isEnabled = false
            submitButton.alpha = 0.5
        }
    }
    
    
    
    @IBAction func submitfeddBackButtonTapped(_ sender: UIButton) {
        
        let call = getTheToken.getToken()
        if call != ""{
            if reviewField.text != ""{
                var reviewToSend = ""
                if let review00 = reviewField.text{
                    reviewToSend = review00
                }
                objectOfReviewViewModel.textReviewSubmitApiCall(tokenToSend: call, restaturantId: placeIsIs, reviewToSend: reviewToSend){ status in
                    if status == true{
                        self.submitButton.isEnabled = false
                        self.submitButton.alpha = 0.5
                        self.reviewFieldHeight.constant = 200
                        self.writereviewHeight.constant = 33
                        self.submitButton.isEnabled = false
                        self.submitButton.alpha = 0.5
                        self.view_2.isHidden = true
                        self.view_3.isHidden = true
                        self.view_4.isHidden = true
                        self.view_5.isHidden = true
                    }else{
                        self.alertMessage(message: "Error while submitting the review try later ...!")
                    }
                }
            }
            if addonlyPhoto == 0{
                if buttonw1 == 0{
                    objectOfReviewViewModel.photoReviewSubmitApiCall(tokenToSend: call, placeIdToSend: placeIsIs, images: photoArray){ status in
                        if status == true{
                            self.reviewFieldHeight.constant = 200
                            self.writereviewHeight.constant = 33
                            self.submitButton.isEnabled = false
                            self.submitButton.alpha = 0.5
                            self.view_2.isHidden = true
                            self.view_3.isHidden = true
                            self.view_4.isHidden = true
                            self.view_5.isHidden = true
                            print("data received")
                        }else{
                            print("data not received")
                        }
                    }
                }
            }else{
                if buttonw1 == 0{
                    objectOfReviewViewModel.photoReviewSubmitApiCall(tokenToSend: call, placeIdToSend: placeIsIs, images: photoArray){ status in
                        if status == true{
                            self.view_2.isHidden = true
                            self.view_3.isHidden = true
                            self.view_4.isHidden = true
                            self.view_5.isHidden = true
                            print("data received")
                        }else{
                            print("data not received")
                        }
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
}

