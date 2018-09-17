//
//  PostVO.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 2..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import ObjectMapper

class PostListVO : Mappable{

    
    
    var message : String?
    var posts : [PostVO] = []
   
    required convenience init?(map:Map){
        self.init()
    }
    
    func mapping(map: Map) {
        message <- map["message"]
        posts <- map["posts"]
        
    }
    

}
