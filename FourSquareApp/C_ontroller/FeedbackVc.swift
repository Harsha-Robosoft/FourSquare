//
//  FeedbackVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 06/01/23.
//

import UIKit

class FeedbackVc: UIViewController {
    
    var objectOfHomeViewModel = HomeViewModel.objectOfViewModel
    var objectOfUserDefaults = UserDefaults()
    var objectOfKeyChain = KeyChain()
    
    
    @IBOutlet weak var feddbackSubmitButton: UIButton!
    @IBOutlet weak var feedBackField: FeedbackFieldBackgroundColour!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func homeButtonTapped(_ sender: UIButton) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: HomeVc.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
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
                    }else{
                        self.alertMessage(message: "Error while sending feedback...!!! . pleace give your feedback once again")
                        
                    }
                    
                }
                
            }else{
                alertMessage(message: "Pleace write your precious feed back")
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
