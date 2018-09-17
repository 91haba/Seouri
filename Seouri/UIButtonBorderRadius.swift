//
//  UIButtonBorderRadius.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 17..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable

class UIButtonBorderRadius : UIButton {
    

    var check = false //true면 버튼 활성화 flase면 비활성화
    

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //setBtnClickEvent()
    }
    
    init(){
        super.init(frame: CGRect.zero)
      //  setBtnClickEvent()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
   //     setBtnClickEvent()
    }

    /*
    func setBtnClickEvent() {
        self.addTarget(self, action: #selector(ToggleButton.touchBtn(_:)), for: UIControlEvents.touchUpInside)
    }
    
    func touchBtn(_ sender: UIButtonBorderRadius) {
        //토글 버튼을 클릭했을 때의 이벤트를 작성해줍니다.
        if (check){
            self.backgroundColor = unclickedColor
            check = false
        }
        else{
            
            self.backgroundColor = clickedBGColor
            check = true
        }
    }*/
    
    
    //--------------------------------------
    
    @IBInspectable var cornerRadius:CGFloat = 0 {
        didSet{
            setCornerRadius()
        }
    }
    
    @IBInspectable var iSCircle:Bool = false {
        didSet{
            setCornerRadius()
        }
    }
    
    @IBInspectable var borderWidth:CGFloat = 0 {
        didSet{
            setBorder()
        }
    }
    
    @IBInspectable var borderColor:UIColor = UIColor.clear {
        didSet{
            setBorder()
        }
    }
    
    func setCornerRadius(){
        
        if iSCircle == true {
            self.layer.cornerRadius = self.bounds.size.width/2
        }
        else{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    func setBorder(){
        
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
    
    
    //Resizeable
    override var intrinsicContentSize: CGSize {
        get {
            let labelSize = titleLabel?.sizeThatFits(CGSize(width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude)) ?? CGSize.zero
            let desiredButtonSize = CGSize(width: labelSize.width + titleEdgeInsets.left + titleEdgeInsets.right, height: labelSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom)
            
            return desiredButtonSize
        }
    }
}

