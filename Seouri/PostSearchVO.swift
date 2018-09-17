//
//  PostSearchVO.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 19..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import ObjectMapper

class PostSearchVO : Mappable {
    
    var message : String?
    var searhcRet : [PostVO] = []
    
    required init?(map: Map) {
    }
    
func mapping(map: Map) {
        message <- map["message"]
        searhcRet <- map["searchRet"]
    }

}
