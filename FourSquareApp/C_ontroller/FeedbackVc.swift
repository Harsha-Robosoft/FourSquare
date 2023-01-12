//
//  FeedbackVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 06/01/23.
//

import UIKit
protocol showHomePage3 {
    func homePage3()
}

class FeedbackVc: UIViewController {
    
    var objectOfHomeViewModel = HomeViewModel.objectOfViewModel
    var objectOfUserDefaults = UserDefaults()
    var objectOfKeyChain = KeyChain()
    
    var homeDelegate3: showHomePage3?
    @IBOutlet weak var feddbackSubmitButton: UIButton!
    @IBOutlet weak var feedBackField: FeedbackFieldBackgroundColour!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        homeDelegate3?.homePage3()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        homeDelegate3?.homePage3()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func feedbackSubmitButton(_ sender: UIButton) {
        let call = getToken()
        if call != ""{
            if feedBackField.text != ""{
                
                guard let feddback = feedBackField.text else{ print("Feedback error")
                    return}
                objectOfHomeViewModel.feedBackApiCall(tokenToSend: call, feedbackIs: feddback){status in
                    if status == true{
                        self.feddbackSubmitButton.isEnabled = false
                        self.feddbackSubmitButton.alpha = 0.5
                    }else{
                        self.alertMessage(message: "Error while sending feedback...!!! . pleace give your feedback once again")
                    }
                }
                
            }else{
                alertMessage(message: "Pleace write your precious feed back")
            }
        }else{
            self.alertMessage(message: "You are not logged in pleace login.")
        }
        
    }
}

extension FeedbackVc{
    
    func getToken() -> String {
        var id = ""
        let userIdIs = objectOfUserDefaults.value(forKey: "userId")
        if let idIs = userIdIs as? String{
            id = idIs
        }
        print("Home id : \(id)")
        guard let receivedTokenData = objectOfKeyChain.loadData(userId: id) else {print("utr 2")
            return ""}
        guard let receivedToken = String(data: receivedTokenData, encoding: .utf8) else {print("utr 3")
            return ""}
        print("Home token",receivedToken)
        return receivedToken
    }
    
}
