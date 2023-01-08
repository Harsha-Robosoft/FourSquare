//
//  PhotoVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 08/01/23.
//

import UIKit

class PhotoVc: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var nameIs = ""
    var placeId = ""
    
    var objectOfUserDefaults = UserDefaults()
    var objectOfKeyChain = KeyChain()
    var objectOfPhotoViewModel = PhotoViewModel.objectOfViewModel
    
    @IBOutlet weak var nameToshoe: UILabel!
    @IBOutlet weak var collectionView01: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameToshoe.text = nameIs
        collectionView01.delegate = self
        collectionView01.dataSource = self
        
        let call = getToken()
        
        if call != ""{
            objectOfPhotoViewModel.getAllPhotosApicall(tokenIs: call, placeIdis: placeId){status in
                if status == true{
                    
                }else{
                    self.collectionView01.isHidden = true
                }
            }
        }else{
            
            let refreshAlert = UIAlertController(title: "ALERT", message: "Are you not loged in. Pleace login", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                
                self.navigationController?.popToRootViewController(animated: true)
                print("Handle Ok logic here")
                
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            present(refreshAlert, animated: true, completion: nil)
            
        }
        
        
        
        
    }
    
    @IBAction func addPhotoButtonTapped(_ sender: UIButton) {
        
        
       
        
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView01.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionCell
        cell.imageIs.image = #imageLiteral(resourceName: "Ferrari-1200-1-1024x683")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let showVc = self.storyboard?.instantiateViewController(withIdentifier: "ShowPhotoVc") as? ShowPhotoVc
        if let vc = showVc{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

extension PhotoVc: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView01.bounds.width / 3 - 3 , height: collectionView01.bounds.width / 3 - 3)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    
}


extension PhotoVc{
    
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
