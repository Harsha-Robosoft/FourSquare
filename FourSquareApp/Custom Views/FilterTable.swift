//
//  FilterTable.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 19/01/23.
//

import Foundation
import UIKit
class FilterTableLabel: UILabel{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func changes() {
        self.textColor = #colorLiteral(red: 0.1960526407, green: 0.1960932612, blue: 0.1960500479, alpha: 1)
    }
    func noChanges() {
        self.textColor = #colorLiteral(red: 0.5528787374, green: 0.5529770851, blue: 0.5528725982, alpha: 1)
    }
    
}

class FilterTableImage: UIImageView{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func changes() {
        self.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.26.22 AM")
    }
    func noChanges() {
        self.image = #imageLiteral(resourceName: "Screenshot 2023-01-05 at 10.29.44 AM")
    }
    
}
