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

class FilterLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }

    func addChanges() {
        self.textColor = #colorLiteral(red: 0.1960526407, green: 0.1960932612, blue: 0.1960500479, alpha: 1)
    }
    
    func noChange()  {
        self.textColor = #colorLiteral(red: 0.5019036531, green: 0.5019937158, blue: 0.5018979907, alpha: 1)
    }

}
