//
//  CGHomeCVCell.swift
//  CgExercise
//
//  Created by Test User 1 on 11/04/18.
//  Copyright © 2018 Capgemini. All rights reserved.
//

import UIKit

class CGHomeCVCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(model: FactModel?) {
        
        if let factObj = model {
            if let textStr = factObj.title {
                titleLabel.text = textStr
            }else {
                titleLabel.text = "No Data"
            }
            imageView.image = nil
            
            print(factObj.title)
            if let url = factObj.imageHref {
//                imageView.downloadImageFromUrl(url)
                APP_DEL.imageLoader.obtainImageWithPath(imagePath: url, completionHandler: { (image) in
                    if image != nil {
                        DispatchQueue.main.async {
                            self.imageView.image = image
                        }

                    }
                })
            }
            
            
        }
    }
    
}
//let imageCache = NSCache()
 
