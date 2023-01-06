//
//  LogInVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 02/01/23.
//

import UIKit

class LogInVc: UIViewController {
    
    var objectOfUserDefaults = UserDefaults()
    var objectOfLoginViewModel = LoginViewModel.objectOfVm

    @IBOutlet weak var emailField: TextFieldBorder!
    @IBOutlet weak var passwordField: TextFieldBorder!
    @IBOutlet weak var loginButton: LoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        
        let homeVc = self.storyboard?.instantiateViewController(identifier: "HomeVc") as? HomeVc
        
        if let vc = homeVc {
            
            objectOfUserDefaults.setValue(1, forKey: "SkipStatus")
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        if emailField.text != "" && passwordField.text != "" {
            
            var emailToSend = ""
            var passwordToSend = ""
            
            if let email = emailField.text{
                
                emailToSend = email
                
            }
            
            if let password = passwordField.text{
                
                passwordToSend = password
            }
            let loader =   self.loader()

            objectOfLoginViewModel.apiCallForUserLogin(emailIs: emailToSend, passwordIs: passwordToSend){ message, status in
                DispatchQueue.main.async() {
                    self.stopLoader(loader: loader)
                if status == true{
                    
                    let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVc") as? HomeVc
                    if let vc = homeVc{
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                }else{
                    DispatchQueue.main.async {
                        self.alertMessage(message: message)

                    }
 
                }
            }
                
            }

            
        }else{
            
            alertMessage(message: "Fields should not be empty ...!")
            
        }
        
        
        
    }
    
    
    @IBAction func createAccountButtonTapped(_ sender: UIButton){
        
        let createAccVc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVc") as? RegisterVc
        
        if let vc = createAccVc {
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func forgotPasswordTapped(_ sender: UIButton) {
        
        let emailVc = self.storyboard?.instantiateViewController(withIdentifier: "EmailValidationVc") as? EmailValidationVc
        
        if let vc = emailVc{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    

}


