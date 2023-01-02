//
//  EmailValidationVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 02/01/23.
//

import UIKit

class EmailValidationVc: UIViewController {
    @IBOutlet weak var emailField: TextFieldBorder!
    @IBOutlet weak var varifyOtpButton: LoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func varifyOtpButtonTapped(_ sender: UIButton) {
        
        let otpVc = self.storyboard?.instantiateViewController(withIdentifier: "VarifyOtpVc") as? VarifyOtpVc
        
        if let vc = otpVc {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
