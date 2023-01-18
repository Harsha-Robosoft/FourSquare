//
//  FavouiretIdModel.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 09/01/23.
//

import Foundation
class FavoriteDetails {
    var placeIs: String
    var _Id: String
    init(placeIs: String,_Id: String) {
        self._Id = _Id
        self.placeIs = placeIs
    }
}
