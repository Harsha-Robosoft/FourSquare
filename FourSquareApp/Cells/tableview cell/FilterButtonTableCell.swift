//
//  FilterButtonTableCell.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 19/01/23.
//

import UIKit

class FilterButtonTableCell: UITableViewCell {

    var shared = SearchViewModel._Shared
    
    
    @IBOutlet weak var updateLable: FilterTableLabel!
    @IBOutlet weak var updateImage: FilterTableImage!
    
    
    func changeTheStatus(filterItem: String) {
        if shared.userFilterChoice.contains(filterItem){
            updateImage.changes()
            updateLable.changes()
        }else{
            updateImage.noChanges()
            updateLable.noChanges()
        }
    }
}
