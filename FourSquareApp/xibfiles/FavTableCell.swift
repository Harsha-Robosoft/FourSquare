//
//  FavTableCell.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 09/01/23.
//

import UIKit
protocol reloadTable {
    func reloadTheTable()
}


class FavTableCell: UITableViewCell {

    var objectOfHomeViewModel = HomeViewModel._shared
    var objectOfAddToFavouiretViewModel = AddToFavoriteViewModel.addToFavoriteViewModel_shared
    var objectOfUserDefaults = UserDefaults()
    var objectOfKeyChain = KeyChain()
    
    var delegateCell: reloadTable?
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageIs: UIImageView!
    @IBOutlet weak var nameIs: UILabel!
    @IBOutlet weak var ratingIs: UILabel!
    @IBOutlet weak var nationalityIs: UILabel!
    @IBOutlet weak var rateIs: UILabel!
    @IBOutlet weak var distanceIs: UILabel!
    
    @IBOutlet weak var addresIs: UILabel!
    @IBOutlet weak var removeButton: UIButton!

    
    var placeId = ""
    
    func setShadow() {
        
        backView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        backView.layer.shadowOpacity = 100
        backView.layer.shadowRadius = 5
        backView.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    @IBAction func removeButtonTapped(_ sender: Any) {
        let call = getToken()
        print("Sending place Id : \(placeId)")
        print("Sending token : \(call)")
        if call != ""{
            objectOfAddToFavouiretViewModel.addPlaceToFavouiretList(tokenTosend: call, placeIdToSend: placeId){ status in
                if status == true{
                    self.objectOfHomeViewModel.userFavouiretListArray = self.objectOfHomeViewModel.userFavouiretListArray.filter { $0 != self.placeId}
                    self.delegateCell?.reloadTheTable()
                    self.objectOfHomeViewModel.AllFavouiretPlaceIdApiCall(tokenTosend: call){ status in
                        if status == true{
                            print("fav id list received")
                        }else{
                            print("fav id list NOT received")
                        }
                    }
                }else{}
            }
        }
    }
}


extension FavTableCell{
    func getToken() -> String {
        var id = ""
        let userIdIs = objectOfUserDefaults.value(forKey: "userId")
        if let idIs = userIdIs as? String{
            id = idIs
        }
        print("Search id : \(id)")
        guard let receivedTokenData = objectOfKeyChain.loadData(userId: id) else {print("utr 2")
            return ""}
        guard let receivedToken = String(data: receivedTokenData, encoding: .utf8) else {print("utr 3")
            return ""}
        print("Search token",receivedToken)
        return receivedToken
    }
}
