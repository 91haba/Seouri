//
//  PostModel.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 2..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class CommunityModel : NetworkModel {
    
    //게시글 작성, 5-1
    func writePost(userID:String, title:String, contents:String,images:[Data?], location:Int){
    
    
        let URL = "\(baseURL)/community"
 
        let header : [String : String] = [
            
            "token" : gsno(token)
        ]
        
        let body : [String : Any] = [
            
            "userId" : userID,
            "title" : title,
            "content" : contents,
            "location" : location
            
        ]
        
        
        Alamofire.upload(multipartFormData:
            {
                multipartFormData in
                print("업로드으으")
                
                for (key,value) in body{
                    
                    if value is String{
                        
                        multipartFormData.append((value as! String).data(using:.utf8)!, withName: key)
                    }
                    else if value is Int{
                        multipartFormData.append("\(value as! Int)".data(using:.utf8)!, withName: key)
                    }
                    
                }
                
                //프로필사진과 멘토 배경은 반드시 들어가야함 클라단에서 처리
                
                
                for image in images{
                    guard let post_image = image else {return}
                    multipartFormData.append(post_image, withName: "images", fileName: "post_image.jpg", mimeType: "image/jpg")
                }
        }
            
            , usingThreshold: UInt64.init(), to: URL, method: .post, headers: header, encodingCompletion: {
                
                encodingResult in
                
                print(encodingResult)
                switch encodingResult{
                    
                case .success(let upload, _, _):
                    
                    upload.responseObject { //res in
                        
                        (res : DataResponse<MessageVO>) in
                        print("게시글 작성 성공여부")
                        switch res.result {
                        case .success:
                            
                            guard let result : MessageVO = res.result.value else{
                                self.view.networkFailed()
                                return
                            }
                            print("게시글작성메시지")
                            print(result.message)
                            if result.message == "Succeed in inserting post."{
                                self.view.networkResult(resultData: "", apiCode: "5-1")
                            }
                            else if result.message == "syntax error"{
                                 self.stopLoading()
                            }
                            else if result.message == "please input all of title, content, userId."{
                                 self.stopLoading()
                            }
                            else if result.message == "no token"{
                                 self.stopLoading()
                                SweetAlert().showAlert("Seouri", subTitle: "계정 정보가 유효하지 않습니다", style: .error, buttonTitle: "확인")
                            }
                            
                        case .failure(let err):
                            print("upload Error : \(err)")
                            DispatchQueue.main.async(execute: {
                                self.view.networkFailed()
                            })
                        }
                    }
                case .failure(let err):
                    print("network Error : \(err)")
                    self.view.networkFailed()
                    
                    
                }
        })
    }//게시글 작성
    
    //게시글 목록 조회, 5-2
    func getPostList(location : Int){
    
        
        let URL = "\(baseURL)/community/list/\(location)"
        let header : [String : String] = [
            
            "token" : gsno(token)
        ]
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseObject{
            
            (response : DataResponse<PostListVO>) in
            switch response.result{
                
            case .success:
                guard let result : PostListVO = response.result.value else {
                    self.view.networkFailed()
                    return
                }
                
                
                if result.message == "Succeed in selecting posts" {
                  
                    self.view.networkResult(resultData : result.posts , apiCode: "5-2")
                    
                }
                else if result.message == "syntax error :  [에러원인]"{
                     self.stopLoading()
                    self.view.networkResult(resultData: "syntax error :  [에러원인]", apiCode: "5-2-syntax error")
                    
                }
                else if result.message == "please input location." {
                     self.stopLoading()
                    self.view.networkResult(resultData: "please input location.", apiCode: "5-2-please input location.")
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
    }//func getPostList
    
    //게시글 상세조회, 5-3
    func getPostDetail(postID : Int){
    
        let URL = "\(baseURL)/community/\(postID)"
        let header : [String : String] = [
            
            "token" : gsno(token)
        ]
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseObject{
            
            (response : DataResponse<PostDetailVO>) in
            switch response.result{
                
            case .success:
                guard let result : PostDetailVO = response.result.value else {
                    self.view.networkFailed()
                    return
                }
                
                
                if result.message == "Succeed in selecting post and comments." {
                    self.view.networkResult(resultData: result, apiCode: "5-3")
                }
                else if result.message ==  "syntax error"{
                    SweetAlert().showAlert("Seouri", subTitle: "Network Error 5-3-syntax error", style: .error, buttonTitle: "확인")
                }
                else if result.message == "please input postId."{
                    SweetAlert().showAlert("Seouri", subTitle: "Network Error 5-3-please input postId.", style: .error, buttonTitle: "확인")
                }
                else if result.message == "no token"{
                    SweetAlert().showAlert("Seouri", subTitle: "계정 정보가 유효하지 않습니다", style: .error, buttonTitle: "확인")
                }
                
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
        }//Alamofire
    }
    
    //댓글 작성, 5-4
    func writeComment(userID: Int, postID:Int, content:String){
    
        let URL = "\(baseURL)/community/comment"
        let header : [String : String] = [
            
            "token" : gsno(token)
        ]
        let body : [String:Any] = [
            
            "userId" : userID,
            "postId" : postID,
            "content" : content
        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseObject{
            
            (response : DataResponse<MessageVO>) in
            
            switch response.result{
                
            case .success:
                guard let result : MessageVO = response.result.value else {
                    self.view.networkFailed()
                    return
                }
                
                
                if result.message == "Succeed in inserting comment." {
                    self.view.networkResult(resultData: "success", apiCode: "5-4")
                }
                else if result.message ==  "syntax error"{
                    self.stopLoading()
                    SweetAlert().showAlert("Seouri", subTitle: "Network Error 5-4-syntax error", style: .error, buttonTitle: "확인")
                }
                else if result.message == "please input all of postId, userId, content."{
                    self.stopLoading()
                    SweetAlert().showAlert("Seouri", subTitle: "Network Error 5-4-please input postId.", style: .error, buttonTitle: "확인")
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
    
    //게시글 검색, 5-5
    func searchPost(searchWord:String){
        
      //  let encoded_search_word = searchWord.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let URL = "\(baseURL)/community/search"
        let header : [String : String] = [
            "token" : gsno(token)
        ]
        let body : [String:String] = [
            "key" : searchWord
        ]
        print("검색어2")
        print(searchWord)
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseObject{
            
            (response : DataResponse<PostSearchVO>) in
            switch response.result{
                
            case .success:
                guard let result : PostSearchVO = response.result.value else {
                    self.view.networkFailed()
                    return
                }
                print("검색 후 요청메시지")
                print(result.message)
                if result.message == "Succeed in search" {
                    self.view.networkResult(resultData: result.searhcRet, apiCode: "5-5")
                }
                else if result.message ==  "syntax error"{
                    SweetAlert().showAlert("Seouri", subTitle: "서버오류입니다 관리자에게 문의해주세요", style: .error, buttonTitle: "확인")
                }
                else if result.message ==  "please input key."{
                    SweetAlert().showAlert("Seouri", subTitle: "검색어를 입력해주세요", style: .error, buttonTitle: "확인")
                }
                else if result.message == "no token"{
                    SweetAlert().showAlert("Seouri", subTitle: "계정 정보가 유효하지 않습니다", style: .error, buttonTitle: "확인")
                }
                
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
        }//Alamofire
        
    }
    
    //게시글 수정, 5-6
    func editPost(postID:Int, title:String, contents:String){
        
        
        let URL = "\(baseURL)/community"
        
        let header : [String : String] = [
            
            "token" : gsno(token)
        ]
        
        let body : [String : Any] = [
            
            "postId" : postID,
            "title" : title,
            "content" : contents,
            
        ]
        
        
        Alamofire.request(URL, method: .put, parameters: body, encoding: JSONEncoding.default, headers: header).responseObject{
            
            (response : DataResponse<MessageVO>) in
            switch response.result{
                
            case .success:
                guard let result : MessageVO = response.result.value else {
                    self.view.networkFailed()
                    return
                }
                print("수정 후 요청메시지")
                print(result.message)
                
                if result.message == "Succeed in updating post." {
                    self.stopLoading()
                    self.view.networkResult(resultData: "success", apiCode: "5-6")
                }
                else if result.message ==  "syntax error"{
                    self.stopLoading()
                    SweetAlert().showAlert("Seouri", subTitle: "서버오류입니다 관리자에게 문의해주세요", style: .error, buttonTitle: "확인")
                }
                else if result.message ==  "please input all of postId, title, content."{
                    self.stopLoading()
                    SweetAlert().showAlert("Seouri", subTitle: "제목과 내용을 확인해주세요", style: .error, buttonTitle: "확인")
                }
             
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
        }//Alamofire
    }//게시글 작성
    
    
    
    
    
    
}
