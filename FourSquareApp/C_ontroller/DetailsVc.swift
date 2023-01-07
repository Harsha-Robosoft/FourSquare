//
//  DetailsVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 07/01/23.
//

import UIKit

class DetailsVc: UIViewController {

    @IBOutlet weak var starOne: UIButton!
    @IBOutlet weak var starTwo: UIButton!
    @IBOutlet weak var starThree: UIButton!
    @IBOutlet weak var starfour: UIButton!
    @IBOutlet weak var starFive: UIButton!
    
    @IBOutlet weak var imageToshow: UIImageView!
    @IBOutlet weak var nameToShow: UILabel!
    @IBOutlet weak var starLikeBuyyon: UIButton!
    @IBOutlet weak var overViewToShow: UILabel!
    
    @IBOutlet weak var topView: GradientTop!
    @IBOutlet weak var bottomView: GradientBottom!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    


}
