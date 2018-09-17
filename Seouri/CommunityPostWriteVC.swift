//
//  CommunityPostWriteVC.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 26..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import UIKit
import KMPlaceholderTextView

class CommunityPostWriteVC : UIViewController,UIGestureRecognizerDelegate{
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var titleTxt: UITextField!
    @IBOutlet var add_image: UIButton!
    @IBOutlet var img_number: UILabel!
    @IBOutlet var photo_collection: UICollectionView!
    @IBOutlet var content: KMPlaceholderTextView!
    @IBOutlet var contentView: UIView!
    
    let ud = UserDefaults.standard
    var location : Int = 0
    var img_list : [UIImage?] = []
    var img_list_string : [String] = []
    let post_photo_picker = UIImagePickerController()
    var last_photo_index : Int = 0
    var city : String = ""
    var title_txt : String = ""
    var contentTxt : String = ""
    var postID : Int = 0
    var edit : Bool = false
    
    var new_post_delegate : newPostDelegate?
    
    override func viewDidLoad() {
     
        setBackButton()
        print("넘어온리스트")
        print(img_list_string)
        if edit{
        self.title = "글 수정"
        }
        else{
            self.title = "\(city) 게시판 글쓰기"
        }
        content.layer.borderWidth = 1.0
        content.layer.borderColor = UIColor(hex: "37B0A6").cgColor
        content.layer.cornerRadius = 5.0
        post_photo_picker.delegate = self
        photo_collection.delegate = self
        photo_collection.dataSource = self
        
        add_image.addTarget(self, action: #selector(add_photo(_:)), for: .touchUpInside)
        var tap = UITapGestureRecognizer(target: self, action: #selector(resignTap(_:)))
        var tap2 = UITapGestureRecognizer(target: self, action: #selector(resignTap(_:)))
        tap.delegate = self
        mainView.isUserInteractionEnabled = true
        mainView.addGestureRecognizer(tap)
        contentView.addGestureRecognizer(tap2)
        
        
        if edit{
            titleTxt.text = title_txt
            content.text = contentTxt
            photo_collection.isHidden = true
             edit = false
        }
        else{
            photo_collection.isHidden = false
        }
    }
    
    override func viewWillLayoutSubviews() {
        if edit{
        
            var img_txt : String = ""
            for i in 0...img_list_string.count-1{
            
                if i == img_list_string.count {
                    img_txt.append("photo_\(i+1)")
                }
                else{
                    img_txt.append("photo_\(i+1),")
                }
                var tmp_img_view = UIImageView()
                tmp_img_view.imageFromUrl(img_list_string[i], defaultImgPath: "1")
                let tmp_img = tmp_img_view.image
                img_list.append(tmp_img)
            }//for
            
            img_number.text = img_txt
            
            photo_collection.reloadData()
            edit = false
        }
        else{
            
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    @objc func resignTap(_ sender : UIView){
        titleTxt.resignFirstResponder()
        content.resignFirstResponder()
    }
    
    @objc func add_photo(_ sender : UIButton){
        present(post_photo_picker, animated: true, completion: nil)
    }
    @objc func delete_photo(_ sender : UIButton){
        let index  = sender.tag
        img_list.remove(at: index)
        photo_collection.reloadData()
    }
    
    @IBAction func okButton(_ sender: Any) {
   
        
        let model = CommunityModel(self)
        
        if edit{
            SweetAlert().showAlert("Seouri", subTitle: "게시글을 수정하시겠습니까?", style: .none, buttonTitle: "확인", buttonColor: UIColor(hex: "37B0A6"), otherButtonTitle: "취소" , otherButtonColor: UIColor(hex: "37B0A6")){
                
                (isOk) in
                if isOk {
                    let postId = self.postID
                    let title = self.gsno(self.titleTxt.text)
                    let contents = self.gsno(self.content.text)
                    model.editPost(postID: postId, title: title, contents: contents)
                }
            }
            self.edit = false
        }//if edit

        else{
        SweetAlert().showAlert("Seouri", subTitle: "게시글을 작성하시겠습니까?", style: .none, buttonTitle: "확인", buttonColor: UIColor(hex: "37B0A6"), otherButtonTitle: "취소" , otherButtonColor: UIColor(hex: "37B0A6")){
            
            (isOk) in
            if isOk{
                
                let userID = self.gsno(self.ud.string(forKey:"kakao_id"))
                let title = self.gsno(self.titleTxt.text)
                let contents = self.gsno(self.content.text)
                var photo_list : [Data?] = []
                
                for img in self.img_list{
                    guard let photo = img else {return}
                    if let photo_data = UIImageJPEGRepresentation(photo, 0.1){
                        photo_list.append(photo_data)
                    }
                }

                model.writePost(userID: userID, title: title, contents: contents, images: photo_list, location: self.location)
                }//if isOk
                    else{
                        print("취소오")
                    }
            }
        }//else, edit false
    }//okbutton
}


extension CommunityPostWriteVC : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = photo_collection.dequeueReusableCell(withReuseIdentifier: "PostWriteCollectionCell", for: indexPath) as! PostWriteCollectionCell
        
 
        cell.write_img.layer.cornerRadius = 5.0
        cell.write_img.clipsToBounds = true
        cell.add_photo.tag = indexPath.item
        cell.minus_btn.tag = indexPath.item
        cell.add_photo.addTarget(self, action: #selector(add_photo(_:)), for: .touchUpInside)
        cell.minus_btn.addTarget(self, action: #selector(delete_photo(_:)), for: .touchUpInside)
        cell.minus_btn.isHidden = true
        
        if img_list.count == 0{
            if indexPath.item == 0{
                cell.add_photo.isHidden = false
            }
            else{
                cell.write_img.image = #imageLiteral(resourceName: "noImage")
                cell.add_photo.isHidden = true
            }
        }
        else{
            //사진이 들어간 셀
            if indexPath.item <= img_list.count - 1{
                if let photo = img_list[indexPath.item]{
                    last_photo_index = img_list.count - 1
                    cell.write_img.image = photo
                    cell.add_photo.isHidden = true
                    cell.minus_btn.isHidden = false
                }
                //인덱스 초과
                else{
                    if indexPath.item == last_photo_index + 1{
                        cell.add_photo.isHidden = false
                        cell.minus_btn.isHidden = true
                    }
                    else{
                        cell.add_photo.isHidden = true
                        }
                    }
            }
            else{
                cell.write_img.image = #imageLiteral(resourceName: "noImage")
                
                if indexPath.item == last_photo_index + 1{
                    cell.add_photo.isHidden = false
                    cell.minus_btn.isHidden = true
                }
                else{
                    cell.add_photo.isHidden = true
                }
                
            }
        }//else
        
        return cell
    }
    
}


extension CommunityPostWriteVC : UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            img_list.append(possibleImage)

            var img_file_txt : String = ""
            for i in 1...self.img_list.count{
                if i == self.img_list.count {
                    img_file_txt + "photo_\(i)"
                }
                else{
                    img_file_txt + "photo_\(i),"
                }
            }
            print(img_file_txt)
            self.img_number.text = img_file_txt
            dismiss(animated: true){
               () in
                self.photo_collection.reloadData()
            }
        }
        else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            img_list.append(possibleImage)
            print("##$$$!@#")
            var img_file_txt : String = ""
            for i in 1...self.img_list.count{
                if i == self.img_list.count {
                    img_file_txt += "photo_\(i)"
                }
                else{
                    img_file_txt += "photo_\(i),"
                }
            }
            print(img_file_txt)
            self.img_number.text = img_file_txt
            dismiss(animated: true){
                () in
                self.photo_collection.reloadData()
    
            }
        }
        else {
            
            dismiss(animated: true){
                 () in
                
                self.photo_collection.reloadData()
                

            }
            return
        }
     
    }
}


extension CommunityPostWriteVC : NetworkCallback {
    
    func networkResult(resultData: Any, apiCode: String) {
        if apiCode == "5-1" {
            
            SweetAlert().showAlert("Seouri", subTitle: "게시글 작성 완료", style: .success, buttonTitle: "확인", buttonColor: UIColor(hex: "37B0A6")) {
                
                (ok) in
                if ok {
                    self.new_post_delegate?.newPost(new: true)
                    CATransaction.begin()
                    self.navigationController?.popViewController(animated: true)
                    CATransaction.setCompletionBlock({
                        () in
                    })
                    CATransaction.commit()
                }//if ok
            }//SweetAlert
        }//if apiCode 5-1
        
        else if apiCode == "5-6"{
            SweetAlert().showAlert("Seouri", subTitle: "게시글 수정 완료", style: .success, buttonTitle: "확인", buttonColor: UIColor(hex: "37B0A6")) {
                
                (ok) in
                if ok {
                    self.new_post_delegate?.newPost(new: true)
                    CATransaction.begin()
                    self.navigationController?.popViewController(animated: true)
                    CATransaction.setCompletionBlock({
                        () in
                    })
                    CATransaction.commit()
                }//if ok
            }
        }//5-6
    }//networkResult
    
}
