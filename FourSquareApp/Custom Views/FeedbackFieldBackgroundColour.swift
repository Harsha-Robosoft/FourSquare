//
//  FeedbackFieldBackgroundColour.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 06/01/23.
//

import Foundation
import UIKit
class FeedbackFieldBackgroundColour: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        changeColour()
    }

    func changeColour() {
        self.layer.borderColor = #colorLiteral(red: 0.811663568, green: 0.8117427826, blue: 0.8157490492, alpha: 1)
        self.contentVerticalAlignment = .top
    }
    
}
