//
//  CommunityCommentVC.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 26..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import UIKit

class CommunityCommentVC : UIViewController{
    
    @IBOutlet var commentTable: UITableView!
    @IBOutlet var comment_text: UITextView!
    @IBOutlet var send_comment: UIButton!
    var writer_img : String?
    var writer: String?
    
    var comment_list : [PostCommentVO] = []
    
    override func viewDidLoad() {
        commentTable.delegate = self
        commentTable.dataSource = self
    }
    
}

extension CommunityCommentVC : UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = commentTable.dequeueReusableCell(withIdentifier: "CommentHeaderCell") as! CommentHeaderCell
        cell.writer_img.imageFromUrl(gsno(writer_img), defaultImgPath: "me")
        cell.writer.text = gsno(writer)
        
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comment_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment_vo = comment_list[indexPath.row]
        let cell = commentTable.dequeueReusableCell(withIdentifier: "PostCommentCell") as! PostCommentCell
        cell.writer.text = gsno(comment_vo.name)
        cell.content.text = gsno(comment_vo.content)
        cell.time.text = gsno(comment_vo.date)
        
        return cell
    }
    
}




