//
//  UILabel.swift
//  Seouri
//
//  Created by 하태경 on 2017. 9. 19..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import UIKit


extension UILabel {
    
    func requiredHeight() -> CGFloat{
        
        CGFloat.greatestFiniteMagnitude
        let label :UILabel = UILabel(frame : CGRect(x:0,y:0,width:self.frame.width, height:CGFloat.greatestFiniteMagnitude))
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = self.font
        label.text = self.text
        label.sizeToFit()
        
        return label.frame.height
    }
    
}
