//
//  InquireListVO.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 28..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import ObjectMapper


class InquireListVO : Mappable{
    
    
    var message : String?
    var myquestion : [InquireVO]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        message <- map["message"]
        myquestion <- map["myquestion"]
    }
    
}
