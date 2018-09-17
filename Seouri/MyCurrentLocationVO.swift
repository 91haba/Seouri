//
//  MyCurrentLocationVO.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 21..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import ObjectMapper


class MyCurrentLocationVO : Mappable{
    
    var lat : Double?
    var lng : Double?
    
    required init?(map: Map) {
        
    }
    
    
   func mapping(map: Map) {
    
    }
}
