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
        
        let call = getToken()
        
        if call != ""{
            objectOfReviewViewModel.getAllReviewDataApiCall(tokenIs: call, placeIdis: placeId ){ status in
                if status == true{
                    
                }else{
                    
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

    @IBAction func addReviewButtonTapped(_ sender: UIButton) {
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView01.dequeueReusableCell(withIdentifier: "tableCell") as! ReviewCell
        
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
    
}
