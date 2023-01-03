//
//  RegisterVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 02/01/23.
//

import UIKit

class RegisterVc: UIViewController {
    
    var objectOfRegisterViewModel = RegisterViewModel.objectOfVm
    var objectOfOtpvarificationViewModel = OtpvarificationViewModel.objectOfVc
    
    @IBOutlet weak var emailField: TextFieldBorder!
    @IBOutlet weak var mobileNUmberFiewld: TextFieldBorder!
    @IBOutlet weak var passwordField: TextFieldBorder!
    @IBOutlet weak var confirmPasswordField: TextFieldBorder!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func logInButtonTapped(_ sender: UIButton) {
        
        if emailField.text != "" && mobileNUmberFiewld.text != "" && passwordField.text != "" && confirmPasswordField.text != "" {
            
            var mailIdToSend = ""
            var passwordToSend = ""
            var mobilNumberToSend = ""
            
            if let email = emailField.text{
                
                let emailIs = isValidEmail(email: email)
                
                if emailIs == true{
                    
                    mailIdToSend = email
                    
                }else{
                    
                    alertMessage(message: "Enter a valid Email Id...!")
                }

                
            }
            
            if passwordField.text == confirmPasswordField.text{
                
                if let password = passwordField.text{
                    
                    let passwordValid = isValidPassword(pass1: password)

                    if passwordValid == true{
                        
                        passwordToSend = password
                        
                    }else{
                        
                        alertMessage(message: "Enter a strong password...!")
                        
                    }
                    
                }

            }else{
                
                alertMessage(message: "Password and create password are not matching...!")
                
            }
            
            
            if Int(mobileNUmberFiewld.text ?? "") != nil && mobileNUmberFiewld.text?.count == 10{
                
                if let mobileNum = mobileNUmberFiewld.text{
                    
                    mobilNumberToSend = mobileNum

                    
                }
                
                
            }else{
                
                alertMessage(message: "Enter a valid mobile number...!")
            }
            
            print("email : \(mailIdToSend)\npassword : \(passwordToSend)\nmobilenumber : \(mobilNumberToSend)")
            
            if mailIdToSend != "" && passwordToSend != "" && mobilNumberToSend != "" {

                let loader =   self.loader()

                objectOfRegisterViewModel.apiCallForUserRegistration(emailIS: mailIdToSend, mobileNUmberIs: mobilNumberToSend, passwordIs: passwordToSend){ messgage , status in

                    DispatchQueue.main.async() {
                        self.stopLoader(loader: loader)
                    if status == true{

                        let otpVc = self.storyboard?.instantiateViewController(withIdentifier: "VarifyOtpVc") as? VarifyOtpVc

                        if let vc = otpVc{
                            
                            vc.emailId = mailIdToSend
                            
                            self.objectOfOtpvarificationViewModel.sendOtpApiCall(emailToSend: mailIdToSend) { status in
                                
                                if status == true{
                                    self.navigationController?.pushViewController(vc, animated: true)

                                }else{
                                    DispatchQueue.main.async {
                                        self.alertMessage(message: "Error while sending otp...!")

                                    }
                                    
                                }
                            }
                            
                        }

                    }else{
                        
                        DispatchQueue.main.async {
                            self.alertMessage(message: messgage)

                        }


                    }

                    }
                }


            }else{


            }
            
            
            
        }else{
            
            alertMessage(message: "Fields should not be empty ...!")
        }
       
    }
    
}


extension RegisterVc{
    
    public func isValidEmail(email: String) -> Bool {

            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)

            return emailPred.evaluate(with: email)

        }
    
    public func isValidPassword(pass1: String) -> Bool {

            let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=])[A-Za-z\\d$@$!%*?&#]{8,50}"

            return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: pass1)

        }
}

extension UIViewController{
    
    func alertMessage(message: String){
        
            let alert = UIAlertController(title: "ALERT", message: message, preferredStyle: .alert)
        
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
            self.present(alert,animated: true, completion: nil)
        }
    
    func loader() -> UIAlertController {
        
            let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        
            loadingIndicator.hidesWhenStopped = true
        
            loadingIndicator.style = UIActivityIndicatorView.Style.large
        
            loadingIndicator.startAnimating()
        
            alert.view.addSubview(loadingIndicator)
        
            present(alert, animated: true, completion: nil)
        
            return alert
        
        }
        
        func stopLoader(loader : UIAlertController) {
            
            DispatchQueue.main.async {
                
                loader.dismiss(animated: true, completion: nil)
                
            }
            
        }
    
}
