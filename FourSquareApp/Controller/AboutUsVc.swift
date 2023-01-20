//
//  AboutUsVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 06/01/23.
//

import UIKit
protocol showHomePage2 {
    func homePage2()
}

class AboutUsVc: UIViewController {
    
    var aboutUsViewModel_shared = AboutUsViewModel._shared
    
    var homeDelegate2: showHomePage2?
    @IBOutlet weak var labelField: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutUsViewModel_shared.ApiCallForAboutUs(){ status in
            if status == true{
                self.labelField.text = self.aboutUsViewModel_shared.aboutDataIsIS
            }else{}
        }
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
        homeDelegate2?.homePage2()
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func homeButtonTapped(_ sender: UIButton) {
        homeDelegate2?.homePage2()
        self.navigationController?.popViewController(animated: true)
    }
}
