//
//  LeftMenuProtocol.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 3..
//  Copyright © 2017년 SOPT. All rights reserved.
//


import UIKit



enum LeftMenu: Int {
    case 홈 = 0
    case 검색
    case 추천코스
    case 커뮤니티
    case 문의하기
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

