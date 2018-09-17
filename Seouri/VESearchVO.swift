//
//  VESearchVO.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 20..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import ObjectMapper

class VESearchVO : Mappable {
    
    
    var message : String?
    var specificVe : VillageEnterpriseVO?
    
    required init?(map: Map) {
    
    }
    
    func mapping(map: Map) {
        message <- map["message"]
        specificVe <- map["specificVe"]
    }
    
}
