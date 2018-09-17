//
//  UIViewController.swift
//  Seouri
//
//  Created by 하태경 on 2017. 9. 19..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIViewController{
    
    
    

    func simplerAlert(title:String, message msg:String){
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title:"확인",style:.default)
        alert.addAction(okAction)
        present(alert,animated:true)
    }
    
    func setBackButton(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(goback))
    }
    
    func goback(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func gsno(_ value:String?)->String{
        
        guard let value_ = value as? String else{
            return ""
        }
        return value_
    }
    
    func gino(_ value:Int?)->Int{
        
        guard let value_ = value as? Int else{
            return 0
        }
        return value_
    }
    
    func gfno( _ value:Float?)->Float{
        
        guard let value_ = value as? Float else{
            return 0
        }
        return value_
        
    }
    
    func gbno( _ value:Bool?)->Bool{
        
        guard let value_ = value as? Bool else{
            return false
        }
        return value_
        
    }
    
    func gdno(_ value : Double?) -> Double{
        
        guard let value_ = value as? Double else {
            return 0.0
        }
        return value_
    }
    
    func networkFailed(){
        stopLoading()
        SweetAlert().showAlert("Seouri", subTitle: "Error : 인터넷 연결상태를 확인해주세요", style:.error, buttonTitle: "확인", buttonColor: .orange)
        // simplerAlert(title:"AddCampus", message:"네트워크 오류")
    }
    
    func startLoading() {
        
        LoadingView.shared.startLoading(view)
        
    }
    
    
    func stopLoading() {
        
        LoadingView.shared.stopLoading()
        
    }
}
    
