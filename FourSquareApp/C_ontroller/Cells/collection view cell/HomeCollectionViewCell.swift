//
//  HomeCollectionViewCell.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 03/01/23.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var labelToUpdate: UILabel!
    
    override var isSelected: Bool{
        didSet {
            if isSelected {
                labelToUpdate.textColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else {
                labelToUpdate.textColor =  #colorLiteral(red: 0.4375747442, green: 0.3237589002, blue: 0.3851821423, alpha: 1)
            }
        }
    }
}
