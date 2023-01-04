//
//  SearchVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 03/01/23.
//

import UIKit

class SearchVc: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var search: UITextField!
    @IBOutlet weak var nearMe: UITextField!
    
    
    @IBOutlet weak var nearMeView: UIView!
    @IBOutlet weak var tableViewAndViewMap: UIView!
    @IBOutlet weak var mapAndCollectionView: UIView!
    @IBOutlet weak var nearYouAndSuggestion: UIView!
    @IBOutlet weak var filterScreen: UIView!
    @IBOutlet weak var whiteView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        search.delegate = self
        nearMe.delegate = self
        addingPading()
        


        nearMeView.isHidden = true
        tableViewAndViewMap.isHidden = true
        mapAndCollectionView.isHidden = true
        nearYouAndSuggestion.isHidden = true
        filterScreen.isHidden = true
        whiteView.isHidden = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("User tapped on the text field : \(textField.placeholder)")
        
        if let name = textField.placeholder {
            
            if name == "Search"{
                
                nearMeView.isHidden = true
                tableViewAndViewMap.isHidden = true
                mapAndCollectionView.isHidden = true
                nearYouAndSuggestion.isHidden = false
                filterScreen.isHidden = true
                whiteView.isHidden = true
                
            }else{
                
                nearMeView.isHidden = false
                tableViewAndViewMap.isHidden = true
                mapAndCollectionView.isHidden = true
                nearYouAndSuggestion.isHidden = true
                filterScreen.isHidden = true
                whiteView.isHidden = true
                
            }
            
        }
        
        
        
        
        }
    
    func addingPading() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: search.frame.height))
        search.leftView = paddingView
        search.leftViewMode = .always
        
        let paddingView1 = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: nearMe.frame.height))
        nearMe.leftView = paddingView1
        nearMe.leftViewMode = .always
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func filterButtonTapped(_ sender: Any) {
        
        nearMeView.isHidden = true
        tableViewAndViewMap.isHidden = true
        mapAndCollectionView.isHidden = true
        nearYouAndSuggestion.isHidden = true
        filterScreen.isHidden = false
        whiteView.isHidden = true
        
        
    }
    

    
}
