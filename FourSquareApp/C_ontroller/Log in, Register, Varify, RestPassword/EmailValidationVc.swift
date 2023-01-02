//
//  EmailValidationVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 02/01/23.
//

import UIKit

class EmailValidationVc: UIViewController {
    
    var objectOfOtpvarificationViewModel = OtpvarificationViewModel.objectOfVc
    
    @IBOutlet weak var emailField: TextFieldBorder!
    @IBOutlet weak var varifyOtpButton: LoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func varifyOtpButtonTapped(_ sender: UIButton) {
        
        var emailIS = ""
        
        if let mail = emailField.text {
            
            emailIS = mail
        }
        
        objectOfOtpvarificationViewModel.chekMailIdIsValidApiCall(emailIs: emailIS){ status in
            
            if status == true{
                
                let otpVc = self.storyboard?.instantiateViewController(withIdentifier: "VarifyOtpVc") as? VarifyOtpVc
                
                if let vc = otpVc {
                    vc.emailId = emailIS
                    vc.forgotPassword = 1
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                
            }else{
                
                self.alertMessage(message: "Enter a registered mail Id...!")
            }
            
        }
        
        
        
        
        
    }
    
}
