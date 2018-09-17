//
//  WeekvillageEnterpriseVO.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 19..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import ObjectMapper

class WeekvillageEnterpriseVO : Mappable {
    
    
    var villageEnterpriseId : Int = 0
    var name : String?
    var image : String?
    
    required init?(map: Map) {}

    
    func mapping(map: Map) {
        villageEnterpriseId <- map["villageEnterpriseId"]
        name <- map["name"]
        image <- map["photo"]
    }
    
}
