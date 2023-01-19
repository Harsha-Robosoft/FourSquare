//
//  HomeTableViewCell.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 03/01/23.
//

import UIKit
protocol reloadHomeTable {
    func reloadTheTable()
}

class HomeTableViewCell: UITableViewCell {
    
    var objectOfUserDefaults = UserDefaults()
    var objectOfKeyChain = KeyChain()
    var objectOfAddToFavouiretViewModel = AddToFavoriteViewModel.objectOfAddToFavoriteViewModel
    var objectOfHomeViewModel = HomeViewModel.objectOfViewModel
    
    var delegateHomeCell: reloadHomeTable?
        
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageIs: UIImageView!
    @IBOutlet weak var nameIs: UILabel!
    @IBOutlet weak var ratingIs: UILabel!
    @IBOutlet weak var nationalityIs: UILabel!
    @IBOutlet weak var rateIs: UILabel!
    @IBOutlet weak var distanceIs: UILabel!
    
    @IBOutlet weak var addresIs: UILabel!
    @IBOutlet weak var likeButton: DetailsStarsStatus!
    
    var onClick = true
    
    var _Id = ""
    var statusISS = 0
    
    func setShadow() {
        backView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        backView.layer.shadowOpacity = 100
        backView.layer.shadowRadius = 5
        backView.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
   
    func buttonStatus(id: String) {
        if( objectOfHomeViewModel.userFavouiretListArray.contains(_Id) ) {
            likeButton.changes()
            onClick = true
        }
        else {
            likeButton.noChange()
            onClick = false
        }
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        let call = getToken()
        if call != ""{
            if onClick == true{
                objectOfAddToFavouiretViewModel.addPlaceToFavouiretList(tokenTosend: call, placeIdToSend: _Id){ status in
                    if status == true{
                        self.likeButton.noChange()
                        self.onClick = false
                        self.objectOfHomeViewModel.userFavouiretListArray = self.objectOfHomeViewModel.userFavouiretListArray.filter { $0 != self._Id}
                        self.objectOfHomeViewModel.AllFavouiretPlaceIdApiCall(tokenTosend: call){ status in
                            if status == true{
                                print("jsfavuavsckC0000912031029831278")
                                print("fav id list received")
                                self.delegateHomeCell?.reloadTheTable()
                            }else{
                                print("fav id list NOT received")
                            }
                        }
                    }else{
                    }
                }
            }else{

                objectOfAddToFavouiretViewModel.addPlaceToFavouiretList(tokenTosend: call, placeIdToSend: _Id){ status in
                    if status == true{
                        self.likeButton.noChange()
                        self.objectOfHomeViewModel.userFavouiretListArray.append(self._Id)
                        self.onClick = true
                        self.objectOfHomeViewModel.AllFavouiretPlaceIdApiCall(tokenTosend: call){ status in
                            if status == true{
                                print("fav id list received")
                                self.delegateHomeCell?.reloadTheTable()
                            }else{
                                print("fav id list NOT received")
                            }
                        }
                    }else{
                    }
                }
            }
        }else{}
    }
}


extension HomeTableViewCell{
    func getToken() -> String {
        var id = ""
       let userIdIs = objectOfUserDefaults.value(forKey: "userId")
        if let idIs = userIdIs as? String{
            id = idIs
        }
        guard let receivedTokenData = objectOfKeyChain.loadData(userId: id) else {print("utr 2")
            return ""}
        guard let receivedToken = String(data: receivedTokenData, encoding: .utf8) else {print("utr 3")
            return ""}
        return receivedToken
    }
    
}
