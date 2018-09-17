//
//  InquireVC.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 21..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import UIKit

class InquireVC: UIViewController {

    @IBOutlet var isMyInquire: UILabel!
    @IBOutlet var inquireTable: UITableView!
    var inquire_list : [InquireVO] = []
    var new_inquire : Bool = false
    let ud = UserDefaults.standard
    override func viewDidLoad() {
        
        setNavigationBarItem()
        isMyInquire.isHidden = true
        inquireTable.delegate = self
        inquireTable.dataSource = self
        inquireTable.tableFooterView = UIView(frame: .zero)
        inquireTable.separatorStyle = .none
        
        let writeButton : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(inquireWrite(_:)))
        self.navigationItem.rightBarButtonItem = writeButton
        let userId = gino(ud.integer(forKey: "kakao_id"))
        let model = InquireModel(self)
        model.getMyInquireList(userId: userId)
        
        self.title = "나의 문의 목록"
    }
    override func viewWillAppear(_ animated: Bool) {
        if new_inquire{
            let model = InquireModel(self)
            let userId = gino(ud.integer(forKey: "kakao_id"))
            model.getMyInquireList(userId: userId)
            new_inquire = false
        }
    }
    
    @objc func clickedSearch(_ sender : UIBarButtonItem){}
    
    @objc func inquireWrite(_ sender : UIBarButtonItem){
        guard let wvc = storyboard?.instantiateViewController(withIdentifier: "InquireWriteVC") as? InquireWriteVC else{return}
        wvc.new_post_delegate = self
        navigationController?.pushViewController(wvc, animated: true)
    }
    


}


extension InquireVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inquire_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vo = inquire_list[indexPath.row]
        let cell = inquireTable.dequeueReusableCell(withIdentifier: "InquireListCell") as! InquireListCell
        cell.profile_img.imageFromUrl(gsno(vo.profile), defaultImgPath: "me")
        cell.answer_status.text = "답변 대기중"
        cell.title.text = gsno(vo.title)
        cell.writer.text = gsno(vo.name)
        cell.date.text = gsno(vo.date)
        
        cell.profile_img.imageFromUrl(gsno(vo.profile), defaultImgPath:"me")
        return cell
    }
    
}

extension InquireVC : NetworkCallback{
    
    
    func networkResult(resultData: Any, apiCode: String) {
        
        if apiCode == "4-1"{
        inquire_list = resultData as! [InquireVO]
            print("문의하기 리스트")
            print(inquire_list.count)
        inquireTable.reloadData()
        inquireTable.estimatedRowHeight = 100.0
        inquireTable.rowHeight = UITableViewAutomaticDimension
            
            if inquire_list.count == 0{
                isMyInquire.isHidden = false
                inquireTable.isHidden = true
            }else{
                isMyInquire.isHidden = true
                inquireTable.isHidden = false
            }
        }//4-1
    }
}//InquireVC

extension InquireVC : newPostDelegate {
    func newPost(new: Bool) {
        new_inquire = new
    }
}
