//
//  VillageEnterpriseModel.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 3..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class HomeModel : NetworkModel{

    
    //홈 화면 조회, 2-1
    func getHomeInfo(userLat : Double, userLng:Double){
        
        let URL = "\(baseURL)/home"
        let header : [String:String] = [
            "token" : gsno(token)
        ]
        let body : [String:Double] = [
        
            "userLat" : userLat,
            "userLng" : userLng
        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseObject{
            
            (response : DataResponse<HomeVO>) in
            
            print("리스폰쓰")
            print(response.result.error)
            print(response.result.debugDescription)
            switch response.result{
                
            case .success:
                
                guard let result : HomeVO = response.result.value else {
                    self.view.networkFailed()
                    return
                }
                print("home message")
                print(result.message)
                if result.message ==  "Succeed in home" {
                    print("리저어어얼트")
                    print(result)
                    print(result.weekvillageEnterprise)
                    print(result.villageinformation[0].comment)
                    
                    self.view.networkResult(resultData: result, apiCode: "2-1")
                }
                else if result.message ==  "selecting village error"{
                     self.stopLoading()
                    SweetAlert().showAlert("Seouri", subTitle: "Network Error 2-1-selecting village error", style: .error, buttonTitle: "확인")
                }
                else if result.message ==  "please input userLat, userLng."{
                     self.stopLoading()
                    SweetAlert().showAlert("Seouri", subTitle: "Network Error 1-2-please input userLat, userLng.", style: .error, buttonTitle: "확인")
                }
                else if result.message == "no token"{
                     self.stopLoading()
                    SweetAlert().showAlert("Seouri", subTitle: "계정 정보가 유효하지 않습니다", style: .error, buttonTitle: "확인")
                }
                
                
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
        }
    }//getHomeInfo
    
    func resgisterRecruiting(name:String,joburl:String,address:String,pay:String,time:String){
        
        let URL = "\(baseURL)/job"
        let header : [String:String] = [
            "token" : gsno(token)
        ]
        let body : [String:Any] = [
            
            "name" : name,
            "joburl" : joburl,
            "address" : address,
            "pay" : pay,
            "time" : time
        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseObject{
            
            (response : DataResponse<MessageVO>) in
       
            
            switch response.result{
                
            case .success:
                
                guard let result : MessageVO = response.result.value else {
                    self.view.networkFailed()
                    return
                }
           
                if result.message ==  "Succeed in inserting job." {
                    self.view.networkResult(resultData: result, apiCode: "1-2")
                }
                else if result.message == "please input all of name, joburl, address."{
                    self.stopLoading()
                    SweetAlert().showAlert("Seouri", subTitle: "이름,홈페이지,주소는 필수 입력사항입니다", style: .error, buttonTitle: "확인")
                }
                else if result.message == "no token"{
                    self.stopLoading()
                    SweetAlert().showAlert("Seouri", subTitle: "계정 정보가 유효하지 않습니다", style: .error, buttonTitle: "확인")
                }
                
                
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
        }
    }//resgister
}
