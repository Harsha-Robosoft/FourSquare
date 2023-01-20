//
//  ReviewVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 08/01/23.
//

import UIKit

class ReviewVc: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var reviewViewModel_Shared = ReviewViewModel._Shared
    var getTheToken_Shared = GetToken._Shared

    var nameIs = ""
    var placeId = ""
    
    @IBOutlet weak var tableView01: UITableView!
    @IBOutlet weak var nameToshow: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameToshow.text = nameIs
        tableView01.delegate = self
        tableView01.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let call = getTheToken_Shared.getToken()
        if call != ""{
            print("place id for All review : \(placeId)")
            reviewViewModel_Shared.getAllReviewDataApiCall(tokenToSend: call, placeIdToSend: placeId ){ status in
                if status == true{
                    self.tableView01.reloadData()
                }else{
                    self.tableView01.isHidden = true
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
    
    @IBAction func addReviewButtonTapped(_ sender: UIButton){
        
        let call = getTheToken_Shared.getToken()
        
        if call != ""{
            let addReviewVc = self.storyboard?.instantiateViewController(withIdentifier: "AddReviewVc") as? AddReviewVc
            if let vc = addReviewVc{
                vc.placeIsIs = placeId
                self.navigationController?.pushViewController(vc, animated: true)
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
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewViewModel_Shared.allReviewdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView01.dequeueReusableCell(withIdentifier: "tableCell") as! ReviewCell
        var imageIs = reviewViewModel_Shared.allReviewdata[indexPath.row].reviewerImage
        imageIs.insert("s", at: imageIs.index(imageIs.startIndex, offsetBy: 4))
        cell.imageIs.image = getImage(urlString: imageIs)
        cell.nameIs.text = reviewViewModel_Shared.allReviewdata[indexPath.row].reviewBy
        cell.reviewIs.text = reviewViewModel_Shared.allReviewdata[indexPath.row].review
        cell.dateAndTime.text = getDate(date: reviewViewModel_Shared.allReviewdata[indexPath.row].reviewDate)
        return cell
    }
}

extension ReviewVc{
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
