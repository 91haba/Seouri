//
//  myPostsVO.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 25..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import ObjectMapper

class MyPostsVO : Mappable {
    
    var message : String?
    var myPosts : [PostVO] = []
    
    required convenience init?(map:Map){
        self.init()
    }
    
    func mapping(map: Map) {
        message <- map["message"]
        myPosts <- map["myPosts"]
    }
}
