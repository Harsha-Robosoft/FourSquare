//
//  SearchCollectionView.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 04/01/23.
//

import UIKit

class SearchCollectionView: UICollectionViewCell {
    @IBOutlet weak var imageIs: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var backView: UIView!
    
    func setShadow() {

        backView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor

        backView.layer.shadowOpacity = 100

        backView.layer.shadowRadius = 5

        backView.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
}
