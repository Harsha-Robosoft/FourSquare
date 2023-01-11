//
//  ReviewVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 08/01/23.
//

import UIKit

class ReviewVc: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var nameIs = ""
    var placeId = ""
    
    var objectOfReviewViewModel = ReviewViewModel.objectOfViewModel
    var objectOfUserDefaults = UserDefaults()
    var objectOfKeyChain = KeyChain()
    

    
    @IBOutlet weak var tableView01: UITableView!
    @IBOutlet weak var nameToshow: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameToshow.text = nameIs
        tableView01.delegate = self
        tableView01.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let call = getToken()
        if call != ""{
            print("place id for All review : \(placeId)")
            objectOfReviewViewModel.getAllReviewDataApiCall(tokenIs: call, placeIdis: placeId ){ status in
                if status == true{
                    self.tableView01.reloadData()
                }else{
                    self.tableView01.isHidden = true
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

    @IBAction func addReviewButtonTapped(_ sender: UIButton){
        
        let call = getToken()
        
        if call != ""{
            let addReviewVc = self.storyboard?.instantiateViewController(withIdentifier: "AddReviewVc") as? AddReviewVc
            if let vc = addReviewVc{
                vc.placeIsIs = placeId
                self.navigationController?.pushViewController(vc, animated: true)
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
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectOfReviewViewModel.allReviewdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView01.dequeueReusableCell(withIdentifier: "tableCell") as! ReviewCell
        var imageIs = objectOfReviewViewModel.allReviewdata[indexPath.row].reviewerImage
        imageIs.insert("s", at: imageIs.index(imageIs.startIndex, offsetBy: 4))
        cell.imageIs.image = getImage(urlString: imageIs)
        cell.nameIs.text = objectOfReviewViewModel.allReviewdata[indexPath.row].reviewBy
        cell.reviewIs.text = objectOfReviewViewModel.allReviewdata[indexPath.row].review
        cell.dateAndTime.text = getDate(date: objectOfReviewViewModel.allReviewdata[indexPath.row].reviewDate)
        
        return cell
    }
    
    
    
}


extension ReviewVc{
    
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
