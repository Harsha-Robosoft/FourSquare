//
//  MyCollectionViewCell.swift
//  collection 1.0
//
//  Created by Harsha R Mundaragi on 18/11/22.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    static let indentifier = "MyCollectionViewCell"
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func configure(with image: UIImage){
        imageView.image = image
    }
    
    static func nib() -> UINib{
        
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }
}
