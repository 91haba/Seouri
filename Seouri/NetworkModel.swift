//
//  NetworkModel.swift
//  Seouri
//
//  Created by 하태경 on 2017. 9. 19..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

class NetworkModel : NetworkCallback{


    internal let baseURL  = ""
    var token : String? = UserDefaults.standard.string(forKey: "user_token")
  
    var view:NetworkCallback
    
    init(_ view:NetworkCallback){
        self.view = view
    }
    
    func gsno(_ value:String?)->String{
        
        guard let value_ = value else{
            return ""
        }
        return value_
    }
    
    func gino(_ value:Int?)->Int{
        
        guard let value_ = value else{
            return 0
        }
        return value_
    }
    
    func gfno( _ value:Float?)->Float{
        
        guard let value_ = value else{
            return 0
        }
        return value_
        
    }
  
    func networkResult(resultData: Any, apiCode: String) {}
    func networkFailed() {
        print("네트워크오류")
    }
    
    func startLoading() {
        
        LoadingView.shared.startLoading(view as! UIView)
        
    }
    
    func stopLoading() {
        
        LoadingView.shared.stopLoading()
        
    }


}
