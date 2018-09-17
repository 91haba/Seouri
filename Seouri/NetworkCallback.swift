//
//  NetwokrCallback.swift
//  Seouri
//
//  Created by 하태경 on 2017. 9. 19..
//  Copyright © 2017년 SOPT. All rights reserved.
//



protocol NetworkCallback{
    
    func networkResult(resultData: Any, apiCode: String)
    func networkFailed()
    
    
}

extension NetworkCallback{
    
    func dbError(){
        print("Error : Database")
    }
    
    func invalidRequest(){
        print("Error : invalid Request")
    }
    
    func invalidReviewID(){
        print("Error : invalidReviewID")
    }
    
    func noAuthority(){
        print("Error : noAuthority")
    }
    
    func invalidValue(){
        print("Error : invalidValue")
    }
    
    func InvalidCertificationKey(){
        //이메일 인증오류
        print("Error : InvalidCertificationKey")
    }
    
    func invalidAction(){
        //잘못된 액션값 전달
        print("Error : InvalidAction")
    }
    
    func invalidAnnonymousID(){
        //잘못된 자유게시판 id 값
        print("Error : InvalidAnnonymousID")
    }
    
    func invalidAcces(){
        //권한없음 or 잘못된 댓글 ID
        print("Error : InvalidAcces")
        
    }
    
    func invalidCommentID(){
        //잘못된 코멘트 아이디
        print("Error :  InvalidCommentID")
    }
    func invalidFirstKeyword(){
        //키워드에 욕설이 들어간경우
        print("Error : InvalidFirstKeyword")
    }
    func invalidCampusCode(){
        //잘못된 대학코드
        print("Error : InvalidCampusCode")
    }
    
    func invalidUserID(){
        
        //잘못된 유저아이디
        print("Error : InvalidUserID")
    }
    func duplicatedNickName() {
        //중복된 닉네임
        print("Error :  DuplicatedNickName")
        
    }
    func invalidNickname(){
        
        //유효하지 않은 닉네임
        print("Error : InvalidNickname")
    }
    
}
