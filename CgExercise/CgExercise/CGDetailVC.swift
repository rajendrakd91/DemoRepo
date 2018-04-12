//
//  CGDetailVC.swift
//  CgExercise
//
//  Created by Test User 1 on 11/04/18.
//  Copyright © 2018 Capgemini. All rights reserved.
//

import UIKit

class CGDetailVC: UIViewController {

    @IBOutlet weak var bannerImageview: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var model: FactModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let factModel = model {
            if let textStr = factModel.descrip {
                descriptionLabel.text = textStr
            }
             APP_DEL.imageLoader.obtainImageWithPath(imagePath: factModel.imageHref, completionHandler: { (image) in
                if image != nil {
                    DispatchQueue.main.async {
                        self.bannerImageview.image = image
                    }
                }
             })
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
