//
//  textFieldBorderRemove.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 02/01/23.
//

import Foundation
import UIKit
class TextFieldBorder: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addChanges()
    }

    func addChanges() {
        self.borderStyle = .none
    }

}
