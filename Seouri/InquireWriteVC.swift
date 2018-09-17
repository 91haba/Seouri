//
//  InquireWriteVC.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 28..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import UIKit
import KMPlaceholderTextView

class InquireWriteVC : UIViewController,UIGestureRecognizerDelegate {
    
    @IBOutlet var titleTxt: UITextField!
    @IBOutlet var contentTxt: KMPlaceholderTextView!
    @IBOutlet var bottomView_spacing: NSLayoutConstraint!
  
    
    var new_post_delegate : newPostDelegate?
    let ud = UserDefaults.standard
    override func viewDidLoad() {
        setBackButton()
        self.title = "문의하기"
        contentTxt.layer.borderWidth = 1.0
        contentTxt.layer.borderColor = UIColor(hex: "37B0A6").cgColor
        contentTxt.layer.cornerRadius = 5.0
        var tap = UITapGestureRecognizer(target: self, action: #selector(resignTap(_:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    @IBAction func write(_ sender: Any) {
      
        titleTxt.resignFirstResponder()
        contentTxt.resignFirstResponder()
        
        let userId = gino(ud.integer(forKey: "kakao_id"))
        let title = gsno(titleTxt.text)
        let content = gsno(contentTxt.text)
        let model = InquireModel(self)
        model.writeInquire(userId: userId, title: title, content: content)
        startLoading()
        
    }
    
    @objc func resignTap(_ sender : UITapGestureRecognizer? = nil){
        titleTxt.resignFirstResponder()
        contentTxt.resignFirstResponder()
    }
    
    
    func adjustKeyboardHeight(_ show:Bool, _ notification:NSNotification){
        
        if let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            var userInfo = notification.userInfo!
            let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
            let changeInHeight = ( keyboardFrame.height ) * (show ? 1 : -1)
            
            
            UIView.animate(withDuration: animationDuration, animations: {() -> Void
                
                in
                
                if #available(iOS 11, *) {

                    self.view.layoutIfNeeded()
                }else{
                    print("%%%%$%$#")
                    print(changeInHeight)
                    
                    if changeInHeight < 0{
                        self.bottomView_spacing.constant = 0
                    }
                    
                    else if self.bottomView_spacing.constant < changeInHeight {
                        self.bottomView_spacing.constant += changeInHeight
                        print(self.bottomView_spacing.constant)
                        print(changeInHeight)
                        
                    }
                    else{
                        self.bottomView_spacing.constant = changeInHeight
                    }
                    self.view.layoutIfNeeded()
                }
            })
        }//if let keyboardSize
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(note: NSNotification) {
        adjustKeyboardHeight(true, note)
    }
    
    @objc func keyboardWillHide(note: NSNotification) {
        adjustKeyboardHeight(false, note)
    }
    
}

extension InquireWriteVC : NetworkCallback {
 
    func networkResult(resultData: Any, apiCode: String) {
        if apiCode == "4-2"{
            stopLoading()
            SweetAlert().showAlert("Seouri", subTitle: "문의하기 완료", style: .success, buttonTitle: "확인", buttonColor: UIColor(hex: "37B0A6")) {
                
                (ok) in
                if ok {
                    self.new_post_delegate?.newPost(new: true)
                    CATransaction.begin()
                    self.navigationController?.popViewController(animated: true)
                    CATransaction.setCompletionBlock({
                        () in
                    })
                    CATransaction.commit()
                }//if ok
            }//SweetAlert
        }
    }
}
