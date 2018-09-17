//
//  JoinVO.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 18..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import ObjectMapper

class JoinVO : Mappable {
    
    
    var message : String?
    var token : String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        message <- map["message"]
        token <- map["token"]
    }
}
