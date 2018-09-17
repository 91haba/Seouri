//
//  UserDefaults.swift
//  Seouri
//
//  Created by 하태경 on 2017. 9. 19..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import UIKit
import Foundation

extension UserDefaults {
    
    func set(_ color: UIColor, forKey key: String) {
        set(NSKeyedArchiver.archivedData(withRootObject: color), forKey: key)
    }
    
    func color(forKey key: String) -> UIColor? {
        guard let data = data(forKey: key) else { return nil }
        return NSKeyedUnarchiver.unarchiveObject(with: data) as? UIColor
    }
}
