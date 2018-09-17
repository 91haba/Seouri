//
//  VESearchListVO.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 23..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import ObjectMapper

class VESearchListVO : Mappable{
    
    var message : String?
    var list : [VillageEnterpriseVO] = []
    

    required init?(map: Map) {
        
    }
    
  func mapping(map: Map) {
        message <- map["message"]
        list <- map["list"]
    }
    
    
}
