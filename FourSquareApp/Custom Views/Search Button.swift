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

    func showColour() {
        self.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        self.backgroundColor = #colorLiteral(red: 0.1859535873, green: 0.05322092026, blue: 0.2549471855, alpha: 1)
    }
    func dontShowColour() {
        self.setTitleColor(#colorLiteral(red: 0.2764571309, green: 0.1421234608, blue: 0.341637373, alpha: 1), for: .normal)
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
}

