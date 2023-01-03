//
//  ViewController.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 02/01/23.
//

import UIKit

class SplashScreenVc: UIViewController {
    var userDefault = UserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        let logVc = self.storyboard?.instantiateViewController(identifier: "LogInVc") as? LogInVc
        
        if let vc = logVc{
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        var skipStatus = 0
        
        if let status = userDefault.value(forKey: "SkipStatus") as? Int{
            
            skipStatus = status
            
        }
        
        
        if skipStatus == 1 {
            
            let logVc = self.storyboard?.instantiateViewController(identifier: "HomeVc") as? HomeVc
            
            if let vc = logVc{
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            
        }else{
            
            
            
            
        }
        
        
    }


}

