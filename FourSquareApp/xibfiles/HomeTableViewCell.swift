//
//  HomeTableViewCell.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 03/01/23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    var objectOfUserDefaults = UserDefaults()
    var objectOfKeyChain = KeyChain()
    var objectOfAddToFavouiretViewModel = AddToFavouiretViewModel.objectOfAddToFavouiretViewModel
    var objectOfHomeViewModel = HomeViewModel.objectOfViewModel
    
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
   
    func buttonTatus(id: String) {
//        print("id1 :\(objectOfHomeViewModel.favouiretIdData)")

        for i in objectOfHomeViewModel.favouiretIdData{
            
            if i.placeIs == id{
                print("id1 : \(nameIs.text), id2 : \(i.placeIs)")
                likeButton.changes()
                statusISS = 1
            }
        }
        
        if statusISS == 0{
            print("0909",nameIs.text)
            likeButton.noChange()
        }
        
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        
        let call = getToken()
        
        print("Id is is : \(_Id)")
        if call != ""{
            if onClick == true{

                objectOfAddToFavouiretViewModel.addPlaceToFavouiretList(tokenTosend: call, placeIdIs: _Id){ status in
                    
                    if status == true{
                        print("6524135762")
                        self.likeButton.changes()
                        self.onClick = false
                    }else{
//                        self.alertMessage(message: "Error while adding to favouites...!")
                    }
                }
                
                
            }else{
                
                objectOfAddToFavouiretViewModel.addPlaceToFavouiretList(tokenTosend: call, placeIdIs: _Id){ status in
                    
                    if status == true{
                        self.likeButton.noChange()
                        self.onClick = true
                    }else{
//                        self.alertMessage(message: "Error while removing from favouites...!")
                    }
                }
               
            }
        }else{
            
        }
  
    }

}


extension HomeTableViewCell{
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
    
//    func alertMessage(message: String){
//
//            let alert = UIAlertController(title: "ALERT", message: message, preferredStyle: .alert)
//
//            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//
//            self.present(alert,animated: true, completion: nil)
//        }
    
}
