//
//  SplashVC.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 4..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import UIKit

class SplashVC : UIViewController {

    
    let ud = UserDefaults.standard
    let delayInSeconds = 1.0
    
    
    override func viewDidLoad() {

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            
            let id = self.gino(self.ud.integer(forKey: "kakao_id"))
            let kakao_token = self.gsno(self.ud.string(forKey: "kakao_token"))
            let user_token : String = self.gsno(self.ud.string(forKey:"user_token"))
            print("아이디이이")
            print(id)
            print(kakao_token)
            
           if user_token == ""{
             //로그인창으로
            //사용자 앱 최초접속 및 로그아웃시 이 블록으로 접근함
                  guard let lvc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC else {return}
                
                lvc.modalTransitionStyle = .crossDissolve
                self.present(lvc, animated: true, completion: nil)
            }
            else{
            
            let model = UserModel(self)
            let kakao_id = self.gino(self.ud.integer(forKey: "kakao_id"))
            
            print("로그인으로 드러와(스플래시)")
            model.login(userID: kakao_id, kakaoToken: kakao_token)
          
            }

        }
    }


}

extension SplashVC : NetworkCallback{
  
    func networkResult(resultData: Any, apiCode: String) {
        if apiCode == "1-1"{
            stopLoading()
            let loginVO = resultData as! LoginVO
            ud.set(gsno(loginVO.token), forKey: "user_token")
            ud.synchronize()
            print("유저토큰")
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
            stopLoading()
            let model = UserModel(self)
            let userID = gino(ud.integer(forKey: "kakao_id"))
            let kakao_token = gsno(ud.string(forKey: "kakao_token"))
            model.login(userID: userID, kakaoToken: kakao_token)
        }
        else if apiCode == "1-2"{
            stopLoading()
            let loginVO = resultData as! LoginVO
            
            ud.set(gsno(loginVO.token), forKey: "user_token")
            
            ud.set(gsno(loginVO.userInfo?.userId), forKey: "kakao_id")
            ud.set(gsno(loginVO.userInfo?.profile), forKey: "profile_img")
            ud.set(gsno(loginVO.userInfo?.name), forKey: "nickname")
            
            ud.synchronize()
            print("유저토큰")
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
