//
//  PostListVC.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 24..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import UIKit

class CommunityPostListVC : UIViewController {
    
    @IBOutlet var very_big_search: UIImageView!
    @IBOutlet var postList: UITableView!
    @IBOutlet var searchTxt: PaddingTextField!
    @IBOutlet var activate_search_btn: UIButton!
    @IBOutlet var searchBtn: UIButton!
    @IBOutlet var noPost: UILabel!
    
    var post_list : [PostVO] = []
    var location : Int = 0
    var city_txt : String = ""
    var new_post : Bool = false
    
    override func viewDidLoad() {
        setBackButton()
        search_off()
        
        activate_search_btn.addTarget(self, action: #selector(activate_seach(_:)), for: .touchUpInside)
        searchBtn.addTarget(self, action: #selector(searchPostList(_:)), for: .touchUpInside)
        
        noPost.isHidden = true
        
        print("게시판 요청 로케이션값")
        self.title = "\(city_txt) 게시판"
        print(location)
        postList.delegate = self
        postList.dataSource = self
        postList.separatorStyle = .none
        let model = CommunityModel(self)
        model.getPostList(location:location)
        startLoading()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        print("게시판 요청 로케이션값")
        self.title = "\(city_txt) 게시판"
        print(location)
        
        if new_post{
            print("뉴포스트")
            let model = CommunityModel(self)
            model.getPostList(location:location)
            startLoading()
            new_post = false
        }
    }
    
    @objc func activate_seach(_ sender : UIButton){
        if sender.tag == 0{
            search_on()
            sender.tag = 1
        }
        else{
            search_off()
            sender.tag = 0
        }
    }
    
    func search_on(){
        very_big_search.isHidden = false
        searchTxt.isHidden = false
        searchBtn.isHidden = false
        postList.isHidden = true
        activate_search_btn.tag = 1
        
    }
    func search_off(){
        very_big_search.isHidden = true
        searchTxt.isHidden = true
        searchBtn.isHidden = true
         postList.isHidden = false
        activate_search_btn.tag = 0
    }
    
    @objc func searchPostList(_ sender : UIButton){
        let searchTxt : String = gsno(self.searchTxt.text)
        self.searchTxt.resignFirstResponder()
        let model = CommunityModel(self)
        model.searchPost(searchWord: searchTxt)
    }
    
    
    @IBAction func writePost(_ sender: Any) {
        guard let wvc = storyboard?.instantiateViewController(withIdentifier: "CommunityPostWriteVC") as? CommunityPostWriteVC else {return}
        wvc.city = city_txt + " 게시판 글쓰기"
        wvc.location = self.location
        wvc.new_post_delegate = self
        navigationController?.pushViewController(wvc, animated: true)
        
    }


}


extension CommunityPostListVC : UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("몇개지")
        print(post_list.count)
       return post_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = postList.dequeueReusableCell(withIdentifier: "PostListCell") as! PostListCell
        let postVO = post_list[indexPath.row]
        
        cell.title.text = gsno(postVO.title)
        cell.hits.text = "조회수 \(gino(postVO.view_num))"
        cell.wroten_time.text = gsno(postVO.date)
        cell.writer_img.imageFromUrl(gsno(postVO.profile), defaultImgPath: "me")
        cell.writer_img.layer.cornerRadius = cell.writer_img.frame.width / 2
        cell.writer_img.clipsToBounds = true
        cell.writer_txt.text = gsno(postVO.name)

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postVO = post_list[indexPath.row]
        
        guard let dvc = storyboard?.instantiateViewController(withIdentifier: "CommunityPostDetailVC") as? CommunityPostDetailVC else {return}
        dvc.postID = gino(postVO.postId)
        dvc.writer = gsno(postVO.name)
        dvc.profile_img = gsno(postVO.profile)
        dvc.time = gsno(postVO.date)
        dvc.city = city_txt + " 게시판"
        navigationController?.pushViewController(dvc, animated: true)
    
        postList.deselectRow(at: indexPath, animated: true)
    }
}

extension CommunityPostListVC : newPostDelegate{
    func newPost(new: Bool) {
        new_post = new
    }
}

extension CommunityPostListVC : NetworkCallback {
    
    func networkResult(resultData: Any, apiCode: String) {
        
        stopLoading()
        
        if apiCode == "5-2" {
            
            
            post_list = resultData as! [PostVO]
           
            if post_list.count == 0{
               noPost.isHidden = false
                postList.isHidden = true
            }
            else{
                noPost.isHidden = true
                postList.isHidden = false
            }
            search_off()
            postList.reloadData()
            postList.estimatedRowHeight = 200.0
            postList.rowHeight = UITableViewAutomaticDimension
        }
        else if apiCode == "5-5"{
            
            post_list = resultData as! [PostVO]
            
            if post_list.count == 0{
                
                SweetAlert().showAlert("Seouri", subTitle: "게시글이 존재하지 않습니다", style: .none, buttonTitle:"확인" , buttonColor: UIColor(hex: "37B0A6"))
                noPost.isHidden = false
                very_big_search.isHidden = true
                postList.isHidden = true
            }
            else{
                very_big_search.isHidden = true
                noPost.isHidden = true
                postList.isHidden = false
            }
            
            postList.reloadData()
            postList.estimatedRowHeight = 200.0
            postList.rowHeight = UITableViewAutomaticDimension
        }
        
    }
}
