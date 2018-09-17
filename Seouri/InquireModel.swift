//
//  InquireModel.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 27..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper



class InquireModel : NetworkModel{
    
    
    func getMyInquireList(userId:Int){
        
        let URL = "\(baseURL)/question/\(userId)"
        
        let header : [String : String] = [
            
            "token" : gsno(token)
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseObject{
            
            
            (response : DataResponse<InquireListVO>) in
            
            switch response.result{
            case .success(_):
                
                guard let result : InquireListVO = response.result.value else {
                    self.view.networkFailed()
                    return
                }
                print("문의하기 리스트 요청메시지")
                print(result.message)
                
                if result.message == "Succeed in selecting myquestion" {
                    if let list = result.myquestion {
                         self.stopLoading()
                        self.view.networkResult(resultData: list, apiCode: "4-1")
                    }
                }
                else if result.message == "syntax error"{
                    self.stopLoading()
                }

                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
                
            }
        }
        
    }
    
    
    func writeInquire(userId : Int, title:String,content:String){
        let URL = "\(baseURL)/question"
        
        let header : [String : String] = [
            
            "token" : gsno(token)
        ]
        
        let body : [String:Any] = [
        
            "userId" : userId,
            "title" : title,
            "content" : content
        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseObject{
            
            
            (response : DataResponse<InquireListVO>) in
            
            switch response.result{
            case .success(_):
                
                guard let result : InquireListVO = response.result.value else {
                    self.view.networkFailed()
                    return
                }
                print("문의하기 작성")
                print(result.message)
                
                if result.message == "Succeed in inserting question." {
                        self.view.networkResult(resultData: "success", apiCode: "4-2")
                }
                else if result.message == "syntax error"{
                     self.stopLoading()
                    self.view.networkResult(resultData: "syntax error", apiCode: "4-2-syntax error")
                    
                }
                
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
                
            }
        }
        
    }
    
}
