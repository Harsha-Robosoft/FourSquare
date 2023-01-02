//
//  orLabel.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 02/01/23.
//

import Foundation
import UIKit
class CustomORLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addChanges()
    }

    func addChanges() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 25
    }

}
