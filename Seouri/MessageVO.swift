//
//  MessageVO.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 19..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import ObjectMapper

class MessageVO : Mappable{
    
    var message : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        message <- map["message"]
    }
    
}
