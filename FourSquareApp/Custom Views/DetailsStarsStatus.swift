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
        self.setImage(#imageLiteral(resourceName: "rating_icon_unselected"), for: .normal)
    }

}
