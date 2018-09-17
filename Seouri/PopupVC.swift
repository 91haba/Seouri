//
//  PopupVC.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 21..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import UIKit

class PopupVC: UIViewController,UIGestureRecognizerDelegate {

    @IBOutlet var name: PaddingTextField!
    @IBOutlet var address: PaddingTextField!
    @IBOutlet var payment: PaddingTextField!
    @IBOutlet var time: PaddingTextField!
    
    
    override func viewDidLoad() {
    
        var tap = UITapGestureRecognizer(target: self, action: #selector(resign(_:)))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    @objc func resign(_ sender : UITapGestureRecognizer?){
        name.resignFirstResponder()
        address.resignFirstResponder()
        payment.resignFirstResponder()
        time.resignFirstResponder()
    }
    @IBAction func okButton(_ sender: Any) {
        
        let nameTxt = gsno(name.text)
        let homepageTxt = "www.Seouri.com"
        let addressTxt = gsno(address.text)
        let paymentTxt = gsno(payment.text)
        let timeTxt = gsno(time.text)
        
        if nameTxt == "" || addressTxt == "" || paymentTxt == "" || timeTxt == "" {
            SweetAlert().showAlert("Seouri", subTitle: "기업명, 주소, 급여, 시간은 필수 입력사항입니다", style: .none, buttonTitle: "확인", buttonColor: UIColor(hex: "37B0A6"))
        }
        
        else{

        SweetAlert().showAlert("Seouri", subTitle: "구인등록을 하시겠습니까?", style: .none, buttonTitle: "확인", buttonColor: UIColor(hex: "37B0A6"), otherButtonTitle: "취소", otherButtonColor: UIColor(hex: "37B0A6")){
            
            (ok) in
            if ok{
                let model = HomeModel(self)
                model.resgisterRecruiting(name: nameTxt, joburl: homepageTxt, address: addressTxt, pay: paymentTxt, time: timeTxt)
                }
            }//sweet
        
        }//else
    }
}

extension PopupVC : NetworkCallback{
    
    func networkResult(resultData: Any, apiCode: String) {
        if apiCode == "1-2"{
            stopLoading()
            dismiss(animated: true){
                () in
                SweetAlert().showAlert("Seouri", subTitle: "구인등록완료", style: .success, buttonTitle: "확인")
            }
        }
    }
}
