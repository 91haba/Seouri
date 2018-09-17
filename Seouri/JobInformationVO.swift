//
//  JobInformationVO.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 19..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import ObjectMapper

class JobInformationVO : Mappable {
    
    
    var jobnum : Int = 0
    var name : String?
    var joburl : String?
    var address : String?
    var pay : String?
    var time : String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        jobnum <- map["jobnum"]
        name <- map["name"]
        joburl <- map["joburl"]
        address <- map["address"]
        pay <- map["pay"]
        time <- map["time"]
    }

    
    
    
}
