//
//  DetailsStarsStatus.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 08/01/23.
//

import Foundation
import UIKit
class DetailsStarsStatus: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }

    func changes() {
        self.setImage(#imageLiteral(resourceName: "rating_icon_selected"), for: .normal)
    }
    func noChange() {
//        let image = UIImage(named: "star")
        self.setImage(#imageLiteral(resourceName: "rating_icon_unselected"), for: .normal)
//        self.tintColor = #colorLiteral(red: 0.9873251319, green: 0.669172585, blue: 0.3242347836, alpha: 1)
    }

}
