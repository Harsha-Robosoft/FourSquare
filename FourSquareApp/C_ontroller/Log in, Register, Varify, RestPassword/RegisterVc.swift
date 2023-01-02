//
//  RegisterVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 02/01/23.
//

import UIKit

class RegisterVc: UIViewController {
    @IBOutlet weak var emailField: TextFieldBorder!
    @IBOutlet weak var mobileNUmberFiewld: TextFieldBorder!
    @IBOutlet weak var passwordField: TextFieldBorder!
    @IBOutlet weak var confirmPasswordField: TextFieldBorder!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func logInButtonTapped(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
                
    }
    
}
