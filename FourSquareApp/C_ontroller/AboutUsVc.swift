//
//  AboutUsVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 06/01/23.
//

import UIKit

class AboutUsVc: UIViewController {

    var objectOfAboutUsViewModel = AboutUsViewModel.objectOfViewModel
    
    @IBOutlet weak var labelField: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if objectOfAboutUsViewModel.aboutDataIsIS == ""{
            objectOfAboutUsViewModel.ApiCallForAboutUs(){ status in
                if status == true{
                    self.labelField.text = self.objectOfAboutUsViewModel.aboutDataIsIS
                }else{
                    
                }
                
            }
        }else{
            labelField.text = objectOfAboutUsViewModel.aboutDataIsIS
        }
        
        
        
        
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func homeButtonTapped(_ sender: UIButton) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: HomeVc.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
}
