//
//  PostImageVO.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 18..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import ObjectMapper

class PostImageVO : Mappable {
    
    var image : String?
    
    required convenience init?(map:Map){
        self.init()
    }
    
    func mapping(map: Map) {
        image <- map["image"]
    }
    
}
