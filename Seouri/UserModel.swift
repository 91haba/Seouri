//
//  UserModel.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 2..
//  Copyright © 2017년 SOPT. All rights reserved.
//


import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class UserModel : NetworkModel{

   
    let ud = UserDefaults.standard
    //회원가입 , 1-1
    
    func join(userID : Int, name:String, profile:String, deviceToken:String, kakaoToken:String){

        
        let URL = "\(baseURL)/member"
        
        let body : [String:Any] = [
            
            "userId" : userID,
            "name" : name,
            "profile" : profile,
            "kakaoToken" : kakaoToken,
            "deviceToken" : deviceToken

        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response : DataResponse<LoginVO>) in
            
            switch response.result{
                
            case .success:
                guard let result : LoginVO = response.result.value else {
                    self.view.networkFailed()
                    return
                }
                print("회원가입 후 메시지")
                print(result.message)
                if result.message == "Succeed in inserting memberInfo." {
                  
                   self.view.networkResult(resultData: result, apiCode: "1-1")
                    
                }
                else if result.message ==  "syntax error"{
                     self.stopLoading()
                    SweetAlert().showAlert("Seouri", subTitle: "Network Error 1-1-syntax error", style: .error, buttonTitle: "확인")
                }
                else if result.message ==  "please input userId(token)."{
                     self.stopLoading()
                    SweetAlert().showAlert("Seouri", subTitle: "Network Error 1-1-please input postId.", style: .error, buttonTitle: "확인")
                }
                    //중복가입 요청시 로그인처리
                else if result.message == "already has id"{
                    self.view.networkResult(resultData: "already has id", apiCode: "1-1-duplicate")
                }
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
        }//Alamofire
    }
    //로그인 , 1-2
    func login(userID : Int, kakaoToken : String){
        
        let URL = "\(baseURL)/member/login"
        
        let body : [String:Any] = [
            
            "userId" : userID,
            "kakaoToken" : kakaoToken,
            
        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response : DataResponse<LoginVO>) in
            
            switch response.result{
                
            case .success:
                guard let result : LoginVO = response.result.value else {
                    self.view.networkFailed()
                    return
                }
                print("로그인 후 메시지")
                print(result.message)
                if result.message ==  "Succeed into userId authorization" {
                    self.view.networkResult(resultData: result, apiCode: "1-2")
                }
                else if result.message ==  "syntax error"{
                     self.stopLoading()
                    SweetAlert().showAlert("Seouri", subTitle: "Network Error 1-2-syntax error", style: .error, buttonTitle: "확인")
                }
                else if result.message ==  "please input userId(token)."{
                     self.stopLoading()
                    SweetAlert().showAlert("Seouri", subTitle: "Network Error 1-2-please input userId(token).", style: .error, buttonTitle: "확인")
                }
                else if result.message == "userId(token) authorization err"{
                    
                    self.view.networkResult(resultData: "", apiCode: "1-2-newjoin")
                }
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
        }//Alamofire
    }
    
        //마이페이지, 1-3
        func getMypage(userID : Int){
            
            let URL = "\(baseURL)/member/mypage"
            let header : [String : String] = [
                "token" : gsno(token)
            ]
            let body : [String:Int] = [
                
                "userId" : userID

            ]
            
            Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseObject{
                
                (response : DataResponse<MyPostsVO>) in
                
                switch response.result{
                    
                case .success:
                    
                    guard let result : MyPostsVO = response.result.value else {
                        self.view.networkFailed()
                        return
                    }
                    print("마이페이지 불러오기 메시지")
                    print(result.message)
                    if result.message == "Succeed into select info" {
               
                        self.view.networkResult(resultData: result.myPosts, apiCode: "1-3")
                        }
                        
                    else if result.message ==  "syntax error"{
                        self.stopLoading()
                            SweetAlert().showAlert("Seouri", subTitle: "Network Error 1-3-syntax error", style: .error, buttonTitle: "확인")
                        }
                    else if result.message == "please input userId(token)."{
                         self.stopLoading()
                        SweetAlert().showAlert("Seouri", subTitle: "Network Error 1-3-please input userId(token).", style: .error, buttonTitle: "확인")
                    }
                    else if result.message == "no token"{
                         self.stopLoading()
                        SweetAlert().showAlert("Seouri", subTitle: "계정 정보가 유효하지 않습니다", style: .error, buttonTitle: "확인")
                    }
             
                        
                        
                        case .failure(let err):
                        print(err)
                        self.view.networkFailed()
                }
                }//Alamofire
            }

    //
    

}
