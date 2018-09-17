//
//  SearchModel.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 20..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import Alamofire


class SearchModel:NetworkModel {
    
    //특정 마을기업 조회, 3-1
    func searchSpecificVe(villageEnterpriseId : Int){
        
        
        let URL = "\(baseURL)/villageEnterprise/detail/\(villageEnterpriseId)"
        
        let header : [String : String] = [
            
            "token" : gsno(token)
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseObject{
            

            (response : DataResponse<VESearchVO>) in
            
            switch response.result{
            case .success(_):
           
                guard let result : VESearchVO = response.result.value else {
                self.view.networkFailed()
                return
                }
     
                print("마을기업 상세조회 후 메시지")
                print(result.message)
                
                if result.message == "Succeed in selecting Specific VillageEnterprise" {
                    print("머야머야")
                    print(result.specificVe)
                    if let specific = result.specificVe{
                        self.view.networkResult(resultData : specific, apiCode: "3-1")
                    }else{
                        self.stopLoading()
                    }
                }
                else if result.message == "syntax error"{
                     self.stopLoading()
                self.view.networkResult(resultData: "syntax error", apiCode: "3-1-syntax error")
                
                }
                else if result.message == "Not exist Specific VillageEnterprise" {
                     self.stopLoading()
                self.view.networkResult(resultData: "Not exist Specific VillageEnterprise", apiCode: "3-1-Not exist Specific VillageEnterprise")
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
    }
    
    //카테고리별 마을기업 조회
    func getVElistWithLocation(location : Int){
        
        let URL = "\(baseURL)/villageEnterprise/list/\(location)"
        
        let header : [String : String] = [
            
            "token" : gsno(token)
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseObject{
            
            
            (response : DataResponse<VESearchListVO>) in
            
            switch response.result{
            case .success(_):
                
                guard let result : VESearchListVO = response.result.value else {
                    self.view.networkFailed()
                    return
                }
                    print("카테고리별 마을기업 조회후 메시지")
                    print(result.message)
                
                if result.message == "Succeed in selecting location" {
                    
                    self.view.networkResult(resultData : result.list , apiCode: "3-2-location")
                    
                }
                else if result.message == "Succeed in selecting total location" {
                    self.stopLoading()
                    print(result.list[0].villageEnterpriseId)
                     self.stopLoading()
                        self.view.networkResult(resultData : result.list , apiCode: "3-2-all")
                    
                }
                else if result.message == "syntax error"{
                     self.stopLoading()
                    self.view.networkResult(resultData: "syntax error", apiCode: "3-2-syntax error")
                    
                }
                else if result.message == "please input location." {
                     self.stopLoading()
                    self.view.networkResult(resultData: "please input location.", apiCode: "3-2-please input location.")
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
        
    }
    
    
    //검색팝업 조회, 3-3
    func searchSpecificVe(name : String){
        
        let encoded_name = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let URL = "\(baseURL)/villageEnterprise/\(encoded_name!)"
        
        let header : [String : String] = [
            
            "token" : gsno(token)
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseObject{
            
            
            (response : DataResponse<VESearchPopupVO>) in
            
            print("마을기업검색")
            print(response.result)
            switch response.result{
                
            case .success(_):
                
                guard let result : VESearchPopupVO = response.result.value else {
                    self.view.networkFailed()
                    return
                }
                
                print("검색창 검색요청 후 메시지")
                print(result.message)
                
                if result.message == "Succeed in selecting popup" {
                    if let popup = result.popup{
                    self.view.networkResult(resultData : popup , apiCode: "3-3")
                    }
                }
                //서버에러 실패
                else if result.message == "syntax error"{
                    self.stopLoading()
                    self.view.networkResult(resultData: "syntax error", apiCode: "3-3-syntax error")
                    
                }
                //요청메시지 에러
                else if result.message == "please input name." {
                    self.stopLoading()
                    self.view.networkResult(resultData: "Not exist Specific VillageEnterprise", apiCode: "3-3-please input name")
                }
                //요청메시지가 존재하지 않을때
                else if result.message == "Not exist popup"{
                    self.stopLoading()
                    self.view.networkResult(resultData: "Not exist Specific VillageEnterprise", apiCode: "3-3-Not exist popup")
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
    }
    
}
