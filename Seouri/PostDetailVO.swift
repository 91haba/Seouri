//
//  PostSearchVO.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 18..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import ObjectMapper


class PostDetailVO : Mappable {
    
    var message : String?
    var post : [PostVO] = []
    var images : [PostImageVO] = []
    var comments : [PostCommentVO] = []
    
    required convenience init?(map:Map){
        self.init()
    }
    
    func mapping(map: Map) {
        message <- map["message"]
        post <- map["post"]
        images <- map["images"]
        comments <- map["comments"]
    }
    
}
