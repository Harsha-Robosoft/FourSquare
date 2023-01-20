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
    
    var homeViewModel_Shared = HomeViewModel._Shared
    var getTheToken_Shared = GetToken._Shared
    
    var homeDelegate3: showHomePage3?
    @IBOutlet weak var feddbackSubmitButton: UIButton!
    @IBOutlet weak var feedBackField: FeedbackFieldBackgroundColour!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let call = getTheToken_Shared.getToken()
        if call != ""{
            if feedBackField.text != ""{
                guard let feddback = feedBackField.text else{ print("Feedback error")
                    return}
                homeViewModel_Shared.feedBackApiCall(tokenToSend: call, feedbackToSend: feddback){status in
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
            let refreshAlert = UIAlertController(title: "ALERT", message: "You are not loged in. Pleace login", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.navigationController?.popToRootViewController(animated: true)
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            }))
            present(refreshAlert, animated: true, completion: nil)
        }
    }
}

