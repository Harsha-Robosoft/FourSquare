//
//  SearchButtonColourChange.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 05/01/23.
//

import Foundation


import UIKit
class FilterByButtons: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func enable() {
        let image = UIImage(named: "plus")
        self.setTitleColor(#colorLiteral(red: 0.1999615431, green: 0.1999413371, blue: 0.204052031, alpha: 1), for: .normal)
        self.setImage(image, for: .normal)
    }
    func disable() {
        let image = UIImage(named: "checkmark.circle.fill")
        self.setTitleColor(#colorLiteral(red: 0.6625666022, green: 0.6667249799, blue: 0.6666312814, alpha: 1), for: .normal)
        self.setImage(image, for: .normal)
    }
    
}
