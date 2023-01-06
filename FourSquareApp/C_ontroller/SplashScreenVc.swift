//
//  ViewController.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 02/01/23.
//

import UIKit

class SplashScreenVc: UIViewController {
    var objectOfUserDefaults = UserDefaults()
    var objectOfKeyChain = KeyChain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true

        var skipStatus = 0
        var signInStatus = 0
        if let status = objectOfUserDefaults.value(forKey: "SkipStatus") as? Int{
            skipStatus = status
        }
        
        if let signIn = objectOfUserDefaults.value(forKey: "SignIn") as? Int {
            signInStatus = signIn
        }
        
        var id = ""
       let userIdIs = objectOfUserDefaults.value(forKey: "userId")
        
        if let idIs = userIdIs as? String{
            
            id = idIs
            
        }
        print("user if : \(id)")
        print("stored user id : \(id)")
        
        var receivedTokenIs = ""
        
        if let receivedTokenData = objectOfKeyChain.loadData(userId: id){
            
            if let receivedToken = String(data: receivedTokenData, encoding: .utf8){
                
                receivedTokenIs = receivedToken
            }
        }
        
        print("Token si : \(receivedTokenIs)")
        
        if receivedTokenIs != ""{
            print("sihni Home")
            goToHome()
        }else{

        }

        if skipStatus == 1 {
            print("Skip home")
            goToHome()
        }
        if skipStatus == 0{
            goToLogIn()
        }
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var signOutStatus = 0
        var skipStatus = 0
        if let status = objectOfUserDefaults.value(forKey: "SignOut") as? Int{
            signOutStatus = status
        }
        
        if let status = objectOfUserDefaults.value(forKey: "SkipStatus") as? Int{
            skipStatus = status
        }
        
        if signOutStatus == 1{
            goToLogIn()
        }
        
        if skipStatus == 1{
            goToLogIn()
        }
    }
    
    
    
    func goToLogIn() {
        let logVc = self.storyboard?.instantiateViewController(identifier: "LogInVc") as? LogInVc
        
        if let vc = logVc{
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func goToHome() {
        
        let logVc = self.storyboard?.instantiateViewController(identifier: "HomeVc") as? HomeVc
        
        if let vc = logVc{
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

