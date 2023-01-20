//
//  PhotoVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 08/01/23.
//

import UIKit

class PhotoVc: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var getTheToken_shared = GetToken._shared
    var photoViewModel_shared = PhotoViewModel._shared
    
    var nameIs = ""
    var placeId = ""

    @IBOutlet weak var nameToshoe: UILabel!
    @IBOutlet weak var collectionView01: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameToshoe.text = nameIs
        collectionView01.delegate = self
        collectionView01.dataSource = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        let call = getTheToken_shared.getToken()
        if call != ""{
            photoViewModel_shared.getAllPhotosApicall(tokenToSend: call, placeIdToSend: placeId){status in
                if status == true{
                    if self.photoViewModel_shared.AllPhotosDetails.last?.imageIs != ""{
                        self.collectionView01.reloadData()
                    }
                }else{
                    self.collectionView01.isHidden = true
                }
            }
        }else{
            let refreshAlert = UIAlertController(title: "ALERT", message: "You are not loged in. Pleace login", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.navigationController?.popToRootViewController(animated: true)
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            }))
            present(refreshAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func addPhotoButtonTapped(_ sender: UIButton) {
        let addPhotoVc = self.storyboard?.instantiateViewController(withIdentifier: "AddReviewVc") as? AddReviewVc
        if let vc = addPhotoVc{
            vc.placeIsIs = placeId
            vc.addonlyPhoto = 1
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoViewModel_shared.AllPhotosDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView01.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionCell
        var imageIs = photoViewModel_shared.AllPhotosDetails[indexPath.row].imageIs
        imageIs.insert("s", at: imageIs.index(imageIs.startIndex, offsetBy: 4))
        cell.imageIs.image = getImage(urlString: imageIs)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let showVc = self.storyboard?.instantiateViewController(withIdentifier: "ShowPhotoVc") as? ShowPhotoVc
        if let vc = showVc{
            vc.placeName = nameIs
            vc.details = photoViewModel_shared.AllPhotosDetails[indexPath.row]
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
