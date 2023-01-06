//
//  AboutUsVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 06/01/23.
//

import UIKit

class AboutUsVc: UIViewController {

    @IBOutlet weak var labelField: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
