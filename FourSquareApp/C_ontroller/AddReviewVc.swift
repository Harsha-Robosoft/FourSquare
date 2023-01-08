//
//  AddReviewVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 08/01/23.
//

import UIKit

class AddReviewVc: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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

    var buttonw1 = 1
    var buttonw2 = 0
    var buttonw3 = 0
    var buttonw4 = 0
    var buttonw5 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view_2.isHidden = true
        view_3.isHidden = true
        view_4.isHidden = true
        view_5.isHidden = true
        

        // Do any additional setup after loading the view.
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func button_1Tapped(_ sender: UIButton) {
        print(1)
        let imageController = UIImagePickerController()
        imageController.delegate = self
        imageController.sourceType = .photoLibrary
        self.present(imageController, animated: true, completion: nil)
    }
    @IBAction func button_2Tapped(_ sender: UIButton) {
        print(2)
        let imageController = UIImagePickerController()
        imageController.delegate = self
        imageController.sourceType = .photoLibrary
        self.present(imageController, animated: true, completion: nil)
    }
    @IBAction func button_3Tapped(_ sender: UIButton) {
        print(3)
        let imageController = UIImagePickerController()
        imageController.delegate = self
        imageController.sourceType = .photoLibrary
        self.present(imageController, animated: true, completion: nil)
    }
    @IBAction func button_4Tapped(_ sender: UIButton) {
        print(4)
        let imageController = UIImagePickerController()
        imageController.delegate = self
        imageController.sourceType = .photoLibrary
        self.present(imageController, animated: true, completion: nil)
    }
    @IBAction func button_5Tapped(_ sender: UIButton) {
        print(5)
        let imageController = UIImagePickerController()
        imageController.delegate = self
        imageController.sourceType = .photoLibrary
        self.present(imageController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if buttonw1 == 1{
            image_1.image = info[.originalImage] as? UIImage
            button_1.isHidden = true
            view_2.isHidden = false
            buttonw1 = 0
            buttonw2 = 1
        }else if buttonw2 == 1{
            image_2.image = info[.originalImage] as? UIImage
            button_2.isHidden = true
            view_3.isHidden = false
            buttonw2 = 0
            buttonw3 = 1
        }else if buttonw3 == 1{
            image_3.image = info[.originalImage] as? UIImage
            button_3.isHidden = true
            view_4.isHidden = false
            buttonw3 = 0
            buttonw4 = 1
        }else if buttonw4 == 1{
            image_4.image = info[.originalImage] as? UIImage
            button_4.isHidden = true
            view_5.isHidden = false
            buttonw4 = 0
            buttonw5 = 1
        }else if buttonw5 == 1{
            image_5.image = info[.originalImage] as? UIImage
            button_5.isHidden = true
            buttonw5 = 0
        }
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
