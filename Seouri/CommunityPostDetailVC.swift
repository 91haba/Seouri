//
//  CommunityPostDetailVC.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 24..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import UIKit

class CommunityPostDetailVC : UIViewController{
    
    @IBOutlet var detailTable: UITableView!
    @IBOutlet var commentTxt: UITextView!
    @IBOutlet var commentTxt_height: NSLayoutConstraint!
    @IBOutlet var commentWrite: UIButton!
    @IBOutlet var textViewHeight: NSLayoutConstraint!
    @IBOutlet var commentView_bottom: NSLayoutConstraint!
    let ud = UserDefaults.standard
    var postID : Int = 0
    var detailVO : PostDetailVO?
    var city : String = ""
    var writer : String = ""
    var profile_img : String = ""
    var time : String = ""
    var comment_list : [PostCommentVO] = []
    var newCommentVO : PostCommentVO = PostCommentVO()
    
    override func viewDidLoad() {
        print("postID")
        print(postID)
        setBackButton()
        commentTxt.layer.borderWidth = 1.0
        commentTxt.layer.borderColor = UIColor(red: 255.0/255.0, green: 153.0/255.0, blue: 51.0/255.0, alpha: 1.0).cgColor
        commentWrite.layer.borderWidth = 1.0
        commentWrite.layer.borderColor = UIColor(red: 255.0/255.0, green: 153.0/255.0, blue: 51.0/255.0, alpha: 1.0).cgColor
        
        self.title = city
        detailTable.separatorStyle = .none
        detailTable.delegate = self
        detailTable.dataSource = self
        commentWrite.addTarget(self, action: #selector(writeComment(_:)), for: .touchUpInside)
        let model = CommunityModel(self)
        model.getPostDetail(postID: postID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    
    @objc func writeComment(_ sender : UIButton){
        let comment = gsno(commentTxt.text)
        commentTxt.resignFirstResponder()
  
        textViewDidChange(commentTxt)
        
        let userId = gino(ud.integer(forKey: "kakao_id"))
        let postId = self.postID
        let content = gsno(commentTxt.text)
        print(userId)
        print(postId)
        print(comment)
        let model = CommunityModel(self)
        model.writeComment(userID: userId, postID: postId, content: comment)
        startLoading()
    }
    
    @objc func more_see_comment(_ sender : UIButton){
    
        guard let mcvc = storyboard?.instantiateViewController(withIdentifier: "CommunityCommentVC") as? CommunityCommentVC else {return}
      
        if let comment_list = detailVO?.comments {
            mcvc.comment_list = comment_list
        }
        else{
            SweetAlert().showAlert("Seouri", subTitle: "더이상 댓글이 존재하지 않습니다", style: .warning, buttonTitle: "확인", buttonColor:  UIColor(hex: "37B0A6"))
        }
        
        navigationController?.pushViewController(mcvc, animated: true)
        
    }
    
    func adjustKeyboardHeight(_ show:Bool, _ notification:NSNotification){
        
        if let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            var userInfo = notification.userInfo!
            let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
            let changeInHeight = ( keyboardFrame.height ) * (show ? 1 : -1)
            
            
            if #available(iOS 11, *) {
                self.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: changeInHeight , right: 0)
            }
            
            
            UIView.animate(withDuration: animationDuration, animations: {() -> Void
                
                in
                
                if #available(iOS 11, *) {
                    print("ios11")
                    self.view.layoutIfNeeded()
                }else{
                    print("아요에스 텐 드루와")
                self.commentView_bottom.constant += changeInHeight
                    self.view.layoutIfNeeded()
                }
            })
        }//if let keyboardSize
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(note: NSNotification) {
        adjustKeyboardHeight(true, note)
    }
    
    @objc func keyboardWillHide(note: NSNotification) {
        adjustKeyboardHeight(false, note)
    }
    
}

extension CommunityPostDetailVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if comment_list.count == 0{
            return 2
        }
        else {
        return comment_list.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return UITableViewAutomaticDimension
        }
        else if indexPath.row >= 1{
                    return 60
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        if indexPath.row == 0{
            let detail_cell = detailTable.dequeueReusableCell(withIdentifier: "PostDetailCell") as! PostDetailCell
            detail_cell.writer.text = writer
            detail_cell.writer_img.imageFromUrl(profile_img, defaultImgPath: "me")
            print("셀포로우")
            print(detailVO?.post[0].content)
            detail_cell.content.text = detailVO?.post[0].content
            detail_cell.content.frame.size.height = detail_cell.content.contentSize.height
            detail_cell.time.text = time
            detail_cell.writer_img.layer.cornerRadius = detail_cell.writer_img.frame.size.width / 2
            detail_cell.writer_img.clipsToBounds = true
            detail_cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
            if comment_list.count <= 10 {
                detail_cell.more_see.isHidden = true
            }
            else{
                detail_cell.more_see.isHidden = false
            }
          
            return detail_cell
            
        }
        else if indexPath.row >= 1{
            
        let comment_cell = detailTable.dequeueReusableCell(withIdentifier: "PostCommentCell") as! PostCommentCell
        
            if comment_list.count == 0{
                comment_cell.isComment.isHidden = false
                comment_cell.time.isHidden = true
                comment_cell.writer.isHidden = true
                comment_cell.content.isHidden = true
                return comment_cell
            }
           
            else{
                 let comment_vo = comment_list[indexPath.row-1]
                comment_cell.isComment.isHidden = true
                comment_cell.time.isHidden = false
                comment_cell.writer.isHidden = false
                comment_cell.content.isHidden = false
                comment_cell.writer.text  = gsno(comment_vo.name)
                comment_cell.content.text = gsno(comment_vo.content)
                comment_cell.time.text = gsno(comment_vo.date)
                
                return comment_cell
            }
        }
        else{
            return UITableViewCell()
        }
    }
    
}

extension CommunityPostDetailVC : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("게시판 상세보기 사진갯수")
        print(gino(detailVO?.images.count))
        return gino(detailVO?.images.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let img_vo = detailVO?.images[indexPath.item]
        let img_vo_string = gsno(img_vo?.image)

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostDetailCollectionCell", for: indexPath) as! PostDetailCollectionCell
        cell.post_img.imageFromUrl(img_vo_string, defaultImgPath: "1")
       // cell.post_img.layer.cornerRadius = 5.0
       // cell.post_img.clipsToBounds = true
       // cell.post_img.layer.borderWidth = 1.0
        //cell.post_img.layer.borderColor =  UIColor(hex: "37B0A6").cgColor
        
        return cell
    }
}

extension CommunityPostDetailVC : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        let contenSize = commentTxt.contentSize.height
        if commentTxt_height.constant <= (commentTxt.font?.lineHeight)! * 4{
            print("드드드드루와")
            print(contenSize)
            commentTxt_height.constant = contenSize
            commentTxt.setContentOffset(CGPoint.zero, animated: false)
            self.view.layoutIfNeeded()
        }
    }
}

extension CommunityPostDetailVC : NetworkCallback{
    
    func networkResult(resultData: Any, apiCode: String) {
        
        stopLoading()
        if apiCode == "5-3"{
            print("들어온내용들")
            detailVO = resultData as! PostDetailVO
  
            guard var comment_list_ = detailVO?.comments else {return}
            
            if comment_list_.count > 10 {
                repeat {
                     comment_list_.removeLast()
                } while comment_list.count == 10
                self.comment_list = comment_list_
            }
            else{
                if let comment_list_less_eqaul_10 = detailVO?.comments {
                        self.comment_list = comment_list_less_eqaul_10
                }
            }
            
            detailTable.reloadData()
            detailTable.estimatedRowHeight = 200.0
            detailTable.rowHeight = UITableViewAutomaticDimension
        }
        
        else if apiCode == "5-4"{
            stopLoading()
            let nickname = gsno(ud.string(forKey: "nickname"))
            newCommentVO.content = commentTxt.text
            newCommentVO.name = nickname
            newCommentVO.date = "방금"
            comment_list.append(newCommentVO)
            commentTxt.text = ""
            print("댓글수")
            print(comment_list.count)
            
            /* var indexPath : IndexPath = IndexPath()
            if comment_list.count == 0{
                indexPath = IndexPath(row: comment_list.count, section: 0)
            }
            else{
                indexPath = IndexPath(row: comment_list.count-1, section: 0)
            } */
            
            
            let indexPath : IndexPath = IndexPath(row: comment_list.count, section: 0)
            detailTable.reloadSections(IndexSet(0...0), with: .automatic)
//            detailTable.beginUpdates()
//            detailTable.insertRows(at: [indexPath], with: .left)
//            detailTable.endUpdates()
            detailTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
           
        }
     
    }//result
    
}
