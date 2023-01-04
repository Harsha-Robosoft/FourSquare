//
//  Search Button.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 04/01/23.
//

import Foundation
import UIKit
class SearchScreenButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addChanges()
    }

    func addChanges() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = #colorLiteral(red: 0.6012234092, green: 0.535154283, blue: 0.6300910711, alpha: 1)
    }

}

