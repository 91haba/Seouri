//
//  VillageInformationVO.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 19..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import ObjectMapper

class VillageInformationVO : Mappable {
    
    var infornum : Int = 0
    var inforUrl : String?
    var comment : String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        infornum <- map["infornum"]
        inforUrl <- map["inforUrl"]
        comment <- map["comment"]
    }

    
    
}
