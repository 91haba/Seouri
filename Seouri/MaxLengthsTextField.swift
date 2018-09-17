//
//  MaxLengthsTextField.swift
//  Seouri
//
//  Created by 하태경 on 2017. 9. 19..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import UIKit

// 1
private var maxLengths = [UITextField: Int]()

// 2
extension UITextField {
    
    // 3
    @IBInspectable var maxLength: Int {
        get {
            // 4
            guard let length = maxLengths[self] else {
                return Int.max
            }
            return length
        }
        set {
            maxLengths[self] = newValue
            // 5
            addTarget(
                self,
                action: #selector(limitLength),
                for: UIControlEvents.editingChanged
            )
        }
    }
    
    func limitLength(textField: UITextField) {
        // 6
        guard let prospectiveText = textField.text, prospectiveText.characters.count > maxLength else {
            return
        }
        
        let selection = selectedTextRange
        // 7
        text = prospectiveText.substring(with:  Range<String.Index>(prospectiveText.startIndex ..< prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength))
            // prospectiveText.index(start, offsetBy: maxLength)
            // prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
            
        )
        selectedTextRange = selection
    }
    
    
    
    
    func addBorderBottom(borderWidth : CGFloat, color : UIColor){
        
        
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: self.frame.size.height)
        //border.backgroundColor = color.cgColor
        border.borderColor = color.cgColor
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
    }
    
    func underlined(){
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
    }
    
}
