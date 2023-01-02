//
//  LogInVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 02/01/23.
//

import UIKit

class LogInVc: UIViewController {
    
    var userDefault = UserDefaults()
    
    
    
    
    @IBOutlet weak var emailField: TextFieldBorder!
    @IBOutlet weak var passwordField: TextFieldBorder!
    @IBOutlet weak var loginButton: LoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        
        let homeVc = self.storyboard?.instantiateViewController(identifier: "HomeVc") as? HomeVc
        
        if let vc = homeVc {
            
            userDefault.setValue(1, forKey: "SkipStatus")
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    

}
