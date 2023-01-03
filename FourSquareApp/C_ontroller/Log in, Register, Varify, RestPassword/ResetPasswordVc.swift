//
//  ResetPasswordVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 02/01/23.
//

import UIKit

class ResetPasswordVc: UIViewController {
    
    var objectOfForgotPasswordViewModel = ForgotPasswordViewModel.objectOfVm
    
    var mailIdToSend = ""
    
    @IBOutlet weak var newPassword: TextFieldBorder!
    @IBOutlet weak var confirmPassword: TextFieldBorder!
    @IBOutlet weak var submitButton: LoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func submitbuttonTapped(_ sender: UIButton) {
        
        
        
        if newPassword.text == confirmPassword.text{
            
            var passwordToSend = ""
            
            if let pass = newPassword.text{
                var password = isValidPassword(pass1: pass)

                if password == true{
                    
                    passwordToSend = pass
                    
                }else{
                    
                    self.alertMessage(message: "Create a strong password")
                }
            }
            
            if passwordToSend != ""{
                
                let loader =   self.loader()

                objectOfForgotPasswordViewModel.forgotPassewordApiCall(emailIs: mailIdToSend, passwordIs: passwordToSend){ status in
                    DispatchQueue.main.async() {
                        self.stopLoader(loader: loader)
                    if status == true{
                        
                        for controller in self.navigationController!.viewControllers as Array {
                            if controller.isKind(of: LogInVc.self) {
                                self.navigationController!.popToViewController(controller, animated: true)
                                break
                            }
                        }
                        
                    }else{
                        DispatchQueue.main.async {
                            self.alertMessage(message: "Error while resetting the password...!")
                        }
                    }
                }
                    
                }
            }else{
                
            }

        }
        
    }
    
}

extension ResetPasswordVc{
    
    public func isValidPassword(pass1: String) -> Bool {

            let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=])[A-Za-z\\d$@$!%*?&#]{8,50}"

            return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: pass1)

        }
    
}
