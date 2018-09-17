//
//  MypageVC.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 21..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import UIKit

class MypageVC: UIViewController {


    let ud = UserDefaults.standard
    
    @IBOutlet var myPostList: UITableView!
    @IBOutlet var logout_btn: UIButton!
    var mypost_list : [PostVO] = []
   
    override func viewDidLoad() {
        setNavigationBarItem()
        myPostList.delegate = self
        myPostList.dataSource = self
        myPostList.estimatedRowHeight = 150.0
        myPostList.rowHeight = UITableViewAutomaticDimension
        myPostList.separatorStyle = .none
        logout_btn.addTarget(self, action: #selector(logout(_:)), for: .touchUpInside)
   
        let user_id = gino(ud.integer(forKey: "kakao_id"))
        print("유저아이디")
        let model = UserModel(self)
        model.getMypage(userID: user_id)
        startLoading()
    }
    
    @objc func logout(_ sender : UIButton){
        
         let session: KOSession = KOSession.shared()
        
        SweetAlert().showAlert("Seouri", subTitle: "로그아웃 하시겠습니까?", style: .warning, buttonTitle: "확인", buttonColor: UIColor(hex: "37B0A6"), otherButtonTitle: "취소", otherButtonColor : UIColor(hex: "37B0A6")){
            
            (ok) in
            
            if ok {
                session.logoutAndClose{
                    
                    (sucess, error) in
                    if sucess {
                        
                        SweetAlert().showAlert("Seouri", subTitle: "로그아웃 완료", style: .success, buttonTitle: "확인", buttonColor: UIColor(hex: "37B0A6")){
                            
                            (isOk) in
                            if isOk{
                                
                                        self.dismiss(animated: true){
                                        self.ud.removeObject(forKey: "kakao_id")
                                        self.ud.removeObject(forKey: "kakao_token")
                                        self.ud.removeObject(forKey: "nickname")
                                        self.ud.removeObject(forKey: "thumbnail_image")
                                            self.ud.removeObject(forKey: "profile_img")
                                            self.ud.removeObject(forKey: "user_token")
                                }
                            }
                        }
                    }//if sucess
                    else{
                        print("로그아웃 실패")
                    }//else
                    
                }//logoutAndClose
            }
            else{
                
                
            }//else for if ok
        }
    }//logut
    
    @objc func edit_my_post(_ sender : UIButton){
        let index = sender.tag
        let vo = mypost_list[index]
        let community_board = UIStoryboard(name:"Community", bundle: nil)
        guard let wvc = community_board.instantiateViewController(withIdentifier: "CommunityPostWriteVC") as? CommunityPostWriteVC else{return}
       wvc.edit = true
        
        wvc.title_txt = gsno(vo.title)
        wvc.location = gino(vo.location)
        wvc.contentTxt = gsno(vo.content)
        wvc.postID = gino(vo.postId)
        print("제목")
        print(vo.postId)
        print(gsno(vo.title))
        print(gino(vo.location))
        print(gsno(vo.content))
        var img_string_list : [String] = []
        print("이미지지지")
        print(vo.images)
        if vo.images.count == 0{
            
        }
        else{
            for i in 0...vo.images.count-1 {
                var tmp_img_string = gsno(vo.images[i].image)
                img_string_list.append(tmp_img_string)
            }
            print("스트링간다아아아")
            print(img_string_list)
           // wvc.img_list_string = img_string_list
        }

        navigationController?.pushViewController(wvc, animated: true)
        
    }
}

extension MypageVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mypost_list.count + 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let headerCell = myPostList.dequeueReusableCell(withIdentifier: "MypageHeaderCell") as! MypageHeaderCell
        let cell = myPostList.dequeueReusableCell(withIdentifier: "MypageCell") as! MypageCell
       
        
        if indexPath.row == 0{
            
            let img_radius = headerCell.profile_img.layer.frame.width / 2.0
            headerCell.profile_img.layer.cornerRadius = img_radius
            headerCell.profile_img.imageFromUrl(gsno(ud.string(forKey: "profile_img")), defaultImgPath: "me")
            headerCell.profile_img.clipsToBounds = true
            return headerCell
        }
        else if indexPath.row >= 1{
            if mypost_list.count != 0{
                print("인팩")
                print(indexPath.row)
         let vo = mypost_list[indexPath.row - 1]
        cell.postView.layer.borderColor = UIColor(hex: "37B0A6").cgColor
        cell.postView.layer.borderWidth = 1.0
        cell.postView.layer.cornerRadius = 5.0
        cell.title.text = vo.title
        cell.edit_btn.tag = indexPath.row
        cell.edit_btn.addTarget(self, action: #selector(edit_my_post(_:)), for: .touchUpInside)
                return cell
            }
            else{
                return UITableViewCell()
            }
        }
        
        else{
            
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= 1{
        let vo = mypost_list[indexPath.row-1]
        let community_board = UIStoryboard(name: "Community", bundle: nil)
        guard let dvc = community_board.instantiateViewController(withIdentifier: "CommunityPostDetailVC") as? CommunityPostDetailVC else{return}
        dvc.postID = vo.postId
        dvc.writer = gsno(vo.name)
        dvc.profile_img = gsno(vo.profile)
        dvc.time = gsno(vo.date)
        dvc.city = "나의 게시물"
        navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
}

extension MypageVC : NetworkCallback {
    
    
    func networkResult(resultData: Any, apiCode: String) {
        if apiCode == "1-3"{
            stopLoading()
            mypost_list = resultData as! [PostVO]
            print("나의게시물갯수")
            print(mypost_list.count)
            myPostList.reloadData()
            myPostList.estimatedRowHeight = 200.0
            myPostList.rowHeight = UITableViewAutomaticDimension
        }
    }
}
