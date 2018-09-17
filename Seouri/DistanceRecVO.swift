//
//  DistanceRectVO.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 19..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import ObjectMapper

class DistanceRecVO : Mappable {
    
    
    var villageEnterpriseId : Int = 0
    var name : String?
    var address : String?
    var lat : Double = 0.0
    var lng : Double = 0.0
    var phone : String?
    var url : String?
    var category : String?
    var detail : String?
    var article : String?
    var photo : String?
    var location : String?
    var coupon : String?
    var distance : Double = 0.0

    required init?(map: Map) {}
    
    func mapping(map: Map) {
      
       villageEnterpriseId <- map["villageEnterpriseId"]
       name <- map["name"]
       address <- map["address"]
       lat <- map["lat"]
       lng <- map["lng"]
       phone <- map["phone"]
       url <- map["url"]
       category <- map["category"]
       detail <- map["detail"]
       article <- map["article"]
       photo <- map["photo"]
       location <- map["location"]
       coupon <- map["coupon"]
       distance <- map["distance"]

    }
}
