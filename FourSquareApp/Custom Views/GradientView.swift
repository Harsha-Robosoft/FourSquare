//
//  GradientView.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 07/01/23.
//

import Foundation
import UIKit
class GradientTop: UIView {
    var topColor: UIColor =   #colorLiteral(red: 0.2181873024, green: 0.05098670721, blue: 0.1377694905, alpha: 1)
    var bottomColor: UIColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 0.01848779966)
    let gradientLayer = CAGradientLayer()
    override func layoutSubviews() {
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

class GradientBottom: UIView {
    var topColor: UIColor =   #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
    var bottomColor: UIColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 0.01848779966)
    let gradientLayer = CAGradientLayer()
    override func layoutSubviews() {
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.frame = self.bounds
        self.layer.addSublayer(gradientLayer)
    }
}
class GradientLeftToRight: UIView {
    var topColor: UIColor =   #colorLiteral(red: 0.9606800675, green: 0.9608443379, blue: 0.9606696963, alpha: 0.3832138271)
    var bottomColor: UIColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 0.01848779966)
    let gradientLayer = CAGradientLayer()
    override func layoutSubviews() {
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = self.bounds
        self.layer.addSublayer(gradientLayer)
    }
}
