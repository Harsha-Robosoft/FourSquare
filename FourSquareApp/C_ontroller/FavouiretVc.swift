//
//  FavouiretVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 06/01/23.
//

import UIKit

class FavouiretVc: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var favouiretTableView: UITableView!
    @IBOutlet weak var favouiretFilter: UIButton!
    @IBOutlet weak var favouritSearchFielf: UITextField!
    
    
    @IBOutlet weak var popularButton: SearchScreenButton!
    @IBOutlet weak var distanceButton: SearchScreenButton!
    @IBOutlet weak var ratingButton: SearchScreenButton!
    
    @IBOutlet weak var setRadiousField: TextFieldBorder!
    
    @IBOutlet weak var rupeesOne: SearchScreenButton!
    @IBOutlet weak var rupeesTwo: SearchScreenButton!
    @IBOutlet weak var rupeesThree: SearchScreenButton!
    @IBOutlet weak var rupeesFour: SearchScreenButton!
    
    @IBOutlet weak var acceptCreaditcardButton: FilterByButtons!
    
    @IBOutlet weak var delivaryButton: FilterByButtons!
    @IBOutlet weak var dogFriendlyButton: FilterByButtons!
    @IBOutlet weak var familyFriendlyPlace: FilterByButtons!
    @IBOutlet weak var inWalkingDistance: FilterByButtons!
    @IBOutlet weak var outDoorSeating: FilterByButtons!
    @IBOutlet weak var parkingbutton: FilterByButtons!
    @IBOutlet weak var wifiButton: FilterByButtons!
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var delivaryIMage: UIImageView!
    @IBOutlet weak var dogFriendlyImage: UIImageView!
    @IBOutlet weak var familyFriendlyImage: UIImageView!
    @IBOutlet weak var inwalkingImage: UIImageView!
    @IBOutlet weak var outdoorImage: UIImageView!
    @IBOutlet weak var parkingImage: UIImageView!
    @IBOutlet weak var wifiimage: UIImageView!

    var acceptCard = true
    var delivary = true
    var dogFriendly = true
    var familyFriendly = true
    var inWalkingDistanceNum = true
    var outDoorSeatingNum = true
    var parkingNum = true
    var wifiNum = true
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addingPading()
        
        favouiretTableView.register(UINib(nibName: "mapFile", bundle: nil), forCellReuseIdentifier: "cell")
        
        // Do any additional setup after loading the view.
    }
    
    func addingPading() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: favouritSearchFielf.frame.height))
        favouritSearchFielf.leftView = paddingView
        favouritSearchFielf.leftViewMode = .always
    }
    @IBAction func backtapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension FavouiretVc{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favouiretTableView.dequeueReusableCell(withIdentifier: "cell") as! HomeTableViewCell
        return cell
    }
}
