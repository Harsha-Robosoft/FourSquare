//
//  EmailValidationVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 02/01/23.
//

import UIKit

class EmailValidationVc: UIViewController {
    
    var otpvarificationViewModel_Shared = OtpvarificationViewModel._shared
    
    @IBOutlet weak var emailField: TextFieldBorder!
    @IBOutlet weak var varifyOtpButton: LoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func varifyOtpButtonTapped(_ sender: UIButton) {
        
        var emailIS = ""
        
        if let mail = emailField.text {
            
            emailIS = mail
        }
        let loader =   self.loader()

        otpvarificationViewModel_Shared.chekMailIdIsValidApiCall(emailToSend: emailIS.lowercased()){ status in
            
            DispatchQueue.main.async() {
                self.stopLoader(loader: loader)
            if status == true{
                
                let otpVc = self.storyboard?.instantiateViewController(withIdentifier: "VarifyOtpVc") as? VarifyOtpVc
                
                if let vc = otpVc {
                    vc.emailId = emailIS
                    vc.forgotPassword = 1
                    self.otpvarificationViewModel_Shared.sendOtpApiCall(emailToSend: emailIS) { status in
                        
                        DispatchQueue.main.async {
                            if status == true{
                                self.navigationController?.pushViewController(vc, animated: true)

                            }else{
                                DispatchQueue.main.async {
                                    self.alertMessage(message: "Error while sending otp...!")
                                }
                            }
                        }
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.alertMessage(message: "Enter a registered mail Id...!")

                }
                
            }
            }
        }
        
        
        
        
        
    }
    
}
