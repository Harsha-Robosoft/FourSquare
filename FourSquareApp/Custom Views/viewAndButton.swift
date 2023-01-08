//
//  viewAndButton.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 08/01/23.
//

import Foundation
import UIKit
class RatingView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        changes()
    }

    func changes() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = #colorLiteral(red: 0.8234393001, green: 0.8235813975, blue: 0.8234303594, alpha: 1)
    }
}

class RatingButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        changes()
    }

    func changes() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = #colorLiteral(red: 0.819530189, green: 0.8197322488, blue: 0.8154260516, alpha: 1)
    }
}
