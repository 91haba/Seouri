//
//  InquireVO.swift
//  Seouri
//
//  Created by 하태경 on 2017. 11. 5..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import ObjectMapper


class InquireVO : Mappable {
    
    var profile : String?
    var title : String?
    var name : String?
    var date : String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        profile <- map["profile"]
        title <- map["title"]
        name <- map["name"]
        date <- map["date"]
    }

    
}
