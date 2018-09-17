//
//  LoginVC.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 4..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import UIKit
import SnapKit
import Then

class LoginVC : UIViewController{

    @IBOutlet var login: UIButtonBorderRadius!
    
    
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
    
      /*  login.snp.makeConstraints{
            (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view)
            make.width.equalTo(200.0)
            make.height.equalTo(50.0)
        }
        login.then{
            $0.layer.cornerRadius = 15.0
            $0.titleLabel?.adjustsFontSizeToFitWidth = true
        }*/
    }
    @IBAction func loginVC(_ sender: Any) {
      
        let session: KOSession = KOSession.shared()
        
        if session.isOpen() {
            session.close()
        }
        
        session.open(completionHandler: {(error) in
            
            if error == nil {
                
       
                
                if session.isOpen() {

                    UserDefaults.standard.do{
                        $0.set(session.accessToken, forKey: "kakao_token")
                    }
                    print("카카오토큰")
                    print(self.ud.string(forKey: "kakao_token"))
                    self.fetchProfile()
                } else {
                    print("Login Failed")
                }
            } else {
                print("Login Error : \(error!)")
            }
        })
        
    }//loginVC
    
    func fetchProfile() {
        KOSessionTask.meTask{ (userData, error) in
            if error == nil {
                let user = (userData as! KOUser)
                let id = Int(user.id)
                self.ud.set(id, forKey: "kakao_id")
                self.ud.synchronize()
                let account_email = self.gsno(user.email)
                let nickname = user.property(forKey: "nickname") as! String
                self.ud.set(nickname, forKey: "nickname")
                let thumbnailURL = user.property(forKey: "thumbnail_image") as! String
                print("썸네일 유알엘")
                print(thumbnailURL)
                self.ud.set(thumbnailURL, forKey: "profile_img")
                
                let kakao_token = self.gsno(self.ud.string(forKey: "kakao_token"))
                self.ud.synchronize()
          
          
               
            
                let model = UserModel(self)
                let kakao_id = self.gino(self.ud.integer(forKey: "kakao_id"))
                //회원가입
                if self.ud.string(forKey: "user_token") == nil{
                    let device_token = ""
                    model.join(userID: kakao_id, name: nickname, profile: thumbnailURL, deviceToken: device_token, kakaoToken: kakao_token)
                }
                    
                //로그인
                else{
                    model.login(userID: kakao_id, kakaoToken: kakao_token)
                }
                
            
            }
            
            else {
                print("Fetching Failed")
                }
            }
        
        }//fetchProfile
 
    
    @objc func join(_ sender : UIButton){
        
     
    }
 
        
        

}

extension LoginVC : NetworkCallback{
    
    func networkResult(resultData: Any, apiCode: String) {
        //회원가입
        if apiCode == "1-1" {
            stopLoading()
            let loginVO = resultData as! LoginVO
            ud.set(gsno(loginVO.token), forKey: "user_token")
            ud.synchronize()
            print("유저토큰, login vc")
            print(gsno(loginVO.token))
            let main_storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = main_storyboard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
            let leftViewController = main_storyboard.instantiateViewController(withIdentifier: "LeftVC") as! LeftVC
            
            let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
            
            UINavigationBar.appearance().tintColor = UIColor.black
            
            leftViewController.mainVC = nvc
            
            let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
            
            slideMenuController.delegate = mainViewController
            
            present(slideMenuController, animated: true)
        }
        else if apiCode == "1-1-duplicate"{
            print("아이디중복, 로그인vc")
            stopLoading()
           let model = UserModel(self)
            let userID = gino(ud.integer(forKey: "kakao_id"))
            let kakao_token = gsno(ud.string(forKey: "kakao_token"))
            model.login(userID: userID, kakaoToken: kakao_token)
        }
        //로그인
        else if apiCode == "1-2"{
            stopLoading()
            let loginVO = resultData as! LoginVO
            
            ud.set(gsno(loginVO.token), forKey: "user_token")
            ud.set(gsno(loginVO.userInfo?.userId), forKey: "id")
            ud.set(gsno(loginVO.userInfo?.profile), forKey: "profile_img")
            ud.set(gsno(loginVO.userInfo?.name), forKey: "nickname")
            
            ud.synchronize()
            print("1-2 , login-vc")
            print(gsno(loginVO.token))
            print(gsno(loginVO.userInfo?.userId))
            print(gsno(loginVO.userInfo?.profile))
            print(gsno(loginVO.userInfo?.name))
            
            let main_storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = main_storyboard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
            let leftViewController = main_storyboard.instantiateViewController(withIdentifier: "LeftVC") as! LeftVC
            
            let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
            
            UINavigationBar.appearance().tintColor = UIColor.black
            
            leftViewController.mainVC = nvc
            
            let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
            
            slideMenuController.delegate = mainViewController
             present(slideMenuController, animated: true)
        }
        //마이페이지
        else if apiCode == "1-2-newjoin"{
            
            let model = UserModel(self)
            let user_id = self.gino(self.ud.integer(forKey: "kakao_id"))
            let name = self.gsno(self.ud.string(forKey: "nickname"))
            print(self.ud.integer(forKey: "kakao_id"))
            print(self.ud.string(forKey: "nickname"))
            let profile = self.gsno(self.ud.string(forKey: "profile_img"))
            let device_token = ""
            let kakao_token = self.gsno(self.ud.string(forKey: "kakao_token"))
            print("aaa")
            model.join(userID: user_id, name: name, profile: profile, deviceToken: device_token, kakaoToken: kakao_token)
            
        }


    }
    
}
