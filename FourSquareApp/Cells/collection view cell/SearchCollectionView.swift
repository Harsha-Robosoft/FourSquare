//
//  SearchCollectionView.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 04/01/23.
//

import UIKit
protocol reloadHomeTable2 {
   func tableReloda()
}

class SearchCollectionView: UICollectionViewCell {
    
    var userDefaults_Shared = UserDefaults()
    var keyChain_Shared = KeyChain()
    var addToFavouiretViewModel_Shared = AddToFavoriteViewModel.addToFavoriteViewModel_Shared
    var homeViewModel_Shared = HomeViewModel._Shared
    
    var collectionDelegate: reloadHomeTable2?
    
    @IBOutlet weak var imageIs: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var likeButton: DetailsStarsStatus!
    @IBOutlet weak var backView: UIView!
    
    var onClick = true
    
    var _Id = ""
    var statusISS = 0
    
    func setShadow() {

        backView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor

        backView.layer.shadowOpacity = 100

        backView.layer.shadowRadius = 5

        backView.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    func buttonTatus(id: String) {
        if( homeViewModel_Shared.userFavouiretListArray.contains(_Id) ) {
            likeButton.changes()
            onClick = true
        }
        else {
            likeButton.noChange()
            onClick = false
        }
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        
        let call = getToken()
        
        print("Id is is : \(_Id)")
        if call != ""{
            if onClick == true{

                addToFavouiretViewModel_Shared.addPlaceToFavouiretList(tokenTosend: call, placeIdToSend: _Id){ status in
                    if status == true{
                        self.likeButton.noChange()
                        self.onClick = false
                        self.homeViewModel_Shared.userFavouiretListArray = self.homeViewModel_Shared.userFavouiretListArray.filter { $0 != self._Id}
                        self.homeViewModel_Shared.AllFavouiretPlaceIdApiCall(tokenTosend: call){ status in
                            if status == true{
                                print("fav id list received")
                                self.collectionDelegate?.tableReloda()
                            }else{
                                print("fav id list NOT received")
                            }
                        }
                    }else{
                    }
                }
            }else{
                
                addToFavouiretViewModel_Shared.addPlaceToFavouiretList(tokenTosend: call, placeIdToSend: _Id){ status in
                    if status == true{
                        self.likeButton.noChange()
                        self.homeViewModel_Shared.userFavouiretListArray.append(self._Id)
                        self.onClick = true
                        self.homeViewModel_Shared.AllFavouiretPlaceIdApiCall(tokenTosend: call){ status in
                            if status == true{
                                print("fav id list received")
                                self.collectionDelegate?.tableReloda()
                            }else{
                                print("fav id list NOT received")
                            }
                        }
                    }else{
                    }
                }
            }
        }else{
            
        }
  
    }
        
    }
    
extension SearchCollectionView{
    func getToken() -> String {
        var id = ""
       let userIdIs = userDefaults_Shared.value(forKey: "userId")
        if let idIs = userIdIs as? String{
            id = idIs
        }
        print("Search id : \(id)")
        guard let receivedTokenData = keyChain_Shared.loadData(userId: id) else {print("utr 2")
            return ""}
        guard let receivedToken = String(data: receivedTokenData, encoding: .utf8) else {print("utr 3")
            return ""}
        print("Search token",receivedToken)
        return receivedToken
    }
    
}
