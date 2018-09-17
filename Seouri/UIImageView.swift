//
//  UIImageView.swift
//  Seouri
//
//  Created by 하태경 on 2017. 9. 19..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import ImageIO
import Kingfisher


extension UIImageView{
    
    public func imageFromUrl(_ urlString: String?, defaultImgPath : String) {
        let defaultImg = UIImage(named: defaultImgPath)
     
        if let url = urlString {
        
            if url.isEmpty {
           
                self.image = defaultImg
            } else {
            
                print(url)
                self.kf.setImage(with: URL(string: url), placeholder: defaultImg, options: [.transition(.fade(0.5))])
            }
        }
        else {
 
            self.image = defaultImg
        }
    }
    
    
    public func loadGif(name:String){
        
        DispatchQueue.global().async {
            let image = UIImage.gif(name: name)
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
    }
    
}
