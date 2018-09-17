//
//  VESearchPopupVO.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 25..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import ObjectMapper

class VESearchPopupVO : Mappable{
    
    
    var message : String?
    var popup : VillageEnterpriseVO?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        message <- map["message"]
        popup <- map["popup"]
    }
    
}
