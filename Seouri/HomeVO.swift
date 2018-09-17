//
//  HomeVO.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 18..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import ObjectMapper


class HomeVO : Mappable {
    
    
    var message : String?
    var poster : [PostImageVO] = []
    var weekvillageEnterprise : [WeekvillageEnterpriseVO] = []
    var villageinformation : [VillageInformationVO] = []
    var jobinformation : [JobInformationVO] = []
    var distanceRec : DistanceRecVO?
    
    required init?(map: Map) {}
    
    
    func mapping(map: Map) {
        message <- map["message"]
        poster <- map["poster"]
        weekvillageEnterprise <- map["weekvillageEnterprise"]
        villageinformation <- map["villageinformation"]
        jobinformation <- map["jobinformation"]
        distanceRec <- map["distanceRec"]
    }
    
    
}

