//
//  HomeTableViewCell.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 03/01/23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageIs: UIImageView!
    @IBOutlet weak var nameIs: UILabel!
    @IBOutlet weak var ratingIs: UILabel!
    @IBOutlet weak var nationalityIs: UILabel!
    @IBOutlet weak var rateIs: UILabel!
    @IBOutlet weak var distanceIs: UILabel!
    
    @IBOutlet weak var addresIs: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    func setShadow() {
        
//        likeButton.setImage(#imageLiteral(resourceName: "Ferrari-1200-1-1024x683"), for: .normal)
        backView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor

        backView.layer.shadowOpacity = 100

        backView.layer.shadowRadius = 5

        backView.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    
}
