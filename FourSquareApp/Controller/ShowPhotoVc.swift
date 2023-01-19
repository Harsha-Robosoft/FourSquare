//
//  ShowPhotoVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 08/01/23.
//

import UIKit

class ShowPhotoVc: UIViewController {

    var placeName = ""
    var details: PhotosDetails?
    @IBOutlet weak var imageToShow: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var dateToshow: UILabel!
    @IBOutlet weak var nameIs: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var image = ""
        var userImageTo = ""
        var userNameIs = ""
        var dateIs = ""
        
        if let data01 = details?.reviewBy{
            userNameIs = data01
        }
        if let data02 = details?.reviewerImage{
            userImageTo = data02
        }
        if let data03 = details?.imageIs{
            image = data03
        }
        if let data04 = details?.reviewDate{
            dateIs = data04
        }
        userImageTo.insert("s", at: userImageTo.index(userImageTo.startIndex, offsetBy: 4))
        image.insert("s", at: image.index(image.startIndex, offsetBy: 4))
        userImage.image = getImage(urlString: userImageTo)
        imageToShow.image = getImage(urlString: image)
        userName.text = userNameIs.capitalized
        dateToshow.text = getDate(date: dateIs)
        nameIs.text = placeName.capitalized
    }
    

    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        var dateIs: Date?
        if let date = dateFormatter.date(from: date) {
            dateIs = date
        }
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        let result = dateFormatter.string(from: dateIs!)
        return result
    }
    
}
