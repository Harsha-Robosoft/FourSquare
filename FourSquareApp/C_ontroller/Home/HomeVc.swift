//
//  HomeVc.swift
//  FourSquareApp
//
//  Created by Harsha R Mundaragi on 02/01/23.
//

import UIKit


class HomeVc: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, changeTheindex {
    
    
   
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var bottom: NSLayoutConstraint!
    
    @IBOutlet weak var containerBackView: UIView!
    @IBOutlet weak var containerView: UIView!
    var menuOut = false
    
    var pageView: HomePageController?
    
    var collectionItem = ["Near you","Toppic","Popular","Lunch","Coffee"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if navigationController?.responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)) ?? false {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        self.collectionView.performBatchUpdates(nil) { _ in
            self.collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: UICollectionView.ScrollPosition(rawValue: 0))
        }
        
    }

    
    @IBAction func burgerButtonTapped(_ sender: Any) {
        
        if menuOut == false{
            
            leading.constant = 300
            trailing.constant = -300
            top.constant = 50
            bottom.constant = 50
            menuOut = true
        }
        else{
            leading.constant = 0
            trailing.constant = 0
            top.constant = 0
            bottom.constant = 0
            menuOut = false
            
        }
        
        UIView.animate(withDuration: 0.3 , animations: {
            self.view.layoutIfNeeded()
        }) { (status) in
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? HomePageController{
        
            self.pageView = vc
            vc.delegate1 = self
        }
    }
    
    func indexToChange(index: Int) {
        collectionView.scrollToItem(at: [0,index], at: .centeredHorizontally, animated: true)
        collectionView.selectItem(at: [0,index], animated: true, scrollPosition: UICollectionView.ScrollPosition(rawValue: 0))
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        
        let searVc = self.storyboard?.instantiateViewController(withIdentifier: "SearchVc") as? SearchVc
        if let vc = searVc{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

extension HomeVc{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
        cell.labelToUpdate.text = collectionItem[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! HomeCollectionViewCell
        cell.labelToUpdate.textColor = .white
        pageView?.goToPAge(indexIs: indexPath.row)

    }

    
}

extension HomeVc: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width / 5, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
}
