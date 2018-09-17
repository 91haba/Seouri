//
//  CommunityVO.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 18..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import ObjectMapper
class PostVO : Mappable{
    
    var postId : Int = 0
    var userId : Int = 0
    var title : String?
    var content: String?
    var view_num : Int = 0
    var date : String?
    var location : Int = 0
    var name : String?
    var profile : String?
    var images : [PostImageVO] = []
    
    required convenience init?(map:Map){
        self.init()
    }
    
    func mapping(map: Map) {
        postId <- map["postId"]
        userId <- map["userId"]
        title <- map["title"]
        content <- map["content"]
        view_num <- map["view_num"]
        date <- map["date"]
        location <- map["location"]
        name <- map["name"]
        profile <- map["profile"]
        images <- map["images"]
    }
    
}
