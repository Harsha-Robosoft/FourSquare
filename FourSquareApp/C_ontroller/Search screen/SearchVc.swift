//
//  SearchVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 03/01/23.
//

import UIKit

class SearchVc: UIViewController {
    @IBOutlet weak var search: UITextField!
    @IBOutlet weak var nearMe: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        search.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "magnifyingglass" )
        imageView.image = image
        search.leftView = imageView
        
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
