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
        
        objectOfOtpvarificationViewModel.sendOtp(emailToSend: emailId){ status in
            
            if status == true{
                
                self.alertMessage(message: "New otp sent to the mail Id")
            }else{
                
                self.alertMessage(message: "Error while sending the otp...!")
            }
            
        }
        
        
        
    }
    @IBAction func getInButtonTapped(_ sender: UIButton) {
        
        let resetVc = self.storyboard?.instantiateViewController(withIdentifier: "ResetPasswordVc") as? ResetPasswordVc
        if let vc = resetVc{
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
