//
//  UserVO.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 18..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import ObjectMapper

class UserVO : Mappable{
    
    var userId  : String?
    var name : String?
    var profile : String?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        userId <- map["userId"]
        name <- map["name"]
        profile <- map["profile"]
       
    }
    
}
