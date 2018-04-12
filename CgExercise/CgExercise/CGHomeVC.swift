//
//  CGHomeVC.swift
//  CgExercise
//
//  Created by Test User 1 on 11/04/18.
//  Copyright © 2018 Capgemini. All rights reserved.
//

import UIKit

class CGHomeVC: UIViewController {
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    var dataSource = NSMutableArray()
    let manager = CGNetworkManager()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(CGHomeVC.handleRefresh),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureTableView()
        handleRefresh()
    }
    
    func configureTableView() -> Void {
       homeCollectionView.addSubview(refreshControl)

    }
    func handleRefresh() {
        self.dataSource.removeAllObjects()
        manager.getFeeds { (data, error) in
            print(data)
            self.dataSource = data as! NSMutableArray
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.homeCollectionView.reloadData()
            }
        }
   
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeToDetail" {
            let vc = segue.destination as? CGDetailVC
            vc?.model = sender as? FactModel
        }
    }

}

extension CGHomeVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier = "aCell"
        let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CGHomeCVCell
       if let model = dataSource.object(at: indexPath.row) as? FactModel {
            cell?.configureCell(model: model)
        }
        return cell!
 
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       return CGSize(width: collectionView.frame.size.width, height: 200)
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedObj = dataSource.object(at: indexPath.row) as? FactModel {
            performSegue(withIdentifier: "HomeToDetail", sender: selectedObj)
        }
        
    }
    
    
    
}
