//
//  PostDetailVO.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 18..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import ObjectMapper

class PostCommentVO : Mappable{
    
    var commentId : Int = 0
    var postId : Int = 0
    var userId : String?
    var content : String?
    var date : String?
    var name: String?
    
    required convenience init?(map:Map){
        self.init()
    }
    
    func mapping(map: Map) {
        commentId <- map["commentId"]
        postId <- map["postId"]
        userId <- map["uesrId"]
        content <- map["content"]
        date <- map["date"]
        name <- map["name"]
    }
    
    
}
