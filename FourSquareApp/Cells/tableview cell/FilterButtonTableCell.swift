//
//  FilterButtonTableCell.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 19/01/23.
//

import UIKit

class FilterButtonTableCell: UITableViewCell {

    var shared = SearchViewModel.objectOfViewModel
    
    
    @IBOutlet weak var updateLable: FilterTableLabel!
    @IBOutlet weak var updateImage: FilterTableImage!
    
    
    func changeTheStatus(filterItem: String) {
        print("1")
        if shared.userFilterChoice.contains(filterItem){
            print(2)
            updateImage.changes()
            updateLable.changes()
        }else{
            print(3)
            updateImage.noChanges()
            updateLable.noChanges()
        }
    }
}
