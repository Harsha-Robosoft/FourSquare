//
//  VarifyOtpVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 02/01/23.
//

import UIKit

class VarifyOtpVc: UIViewController {
    
    var objectOfOtpvarificationViewModel = OtpvarificationViewModel.objectOfVc
    
    var emailId = ""
    var forgotPassword = 0
    @IBOutlet weak var otpField: TextFieldBorder!
    @IBOutlet weak var getInButton: LoginButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 
    @IBAction func resendOTPTapped(_ sender: UIButton) {
        
        objectOfOtpvarificationViewModel.sendOtpApiCall(emailToSend: emailId){ status in
            
            if status == true{
                
                self.alertMessage(message: "New otp sent to the mail Id")
            }else{
                
                self.alertMessage(message: "Error while sending the otp...!")
            }
            
        }
        
        
        
    }
    @IBAction func getInButtonTapped(_ sender: UIButton) {
        
        if forgotPassword == 0{
            
            var otpToSend = ""
            if let otpIs = otpField.text{
                otpToSend = otpIs
                
            }
            
            objectOfOtpvarificationViewModel.varifyOtpApicall(otpIs: otpToSend){ status in
                
                if status == true{
                    
                    for controller in self.navigationController!.viewControllers as Array {
                        if controller.isKind(of: LogInVc.self) {
                            self.navigationController!.popToViewController(controller, animated: true)
                            break
                        }
                    }

                    
                }else{
                    
                    self.alertMessage(message: "Entered a wrong OTP...!")
                }
                
            }
            
            
        }else{
            var otpToSend = ""
            if let otpIs = otpField.text{
                otpToSend = otpIs
                
            }
            
            objectOfOtpvarificationViewModel.varifyOtpApicall(otpIs: otpToSend){ status in
                
                if status == true{
                    
                    let createPasswordVc = self.storyboard?.instantiateViewController(withIdentifier: "ResetPasswordVc") as? ResetPasswordVc
                    if let vc = createPasswordVc{
                        
                        vc.mailIdToSend = self.emailId
                        self.navigationController?.pushViewController(vc, animated: true)
                    }

                    
                }else{
                    
                    self.alertMessage(message: "Entered a wrong OTP...!")
                }
                
            }
            
        }
        
        
        let resetVc = self.storyboard?.instantiateViewController(withIdentifier: "ResetPasswordVc") as? ResetPasswordVc
        if let vc = resetVc{
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
