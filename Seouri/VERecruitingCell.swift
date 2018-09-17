//
//  VERecruitingCell.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 15..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import UIKit

class VERecruitingCell: UITableViewCell {

    @IBOutlet var recruitCollection: UICollectionView!
    @IBOutlet var registerRecruting: UIButton!
    
    
    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDataSource & UICollectionViewDelegate>
        (dataSourceDelegate: D, forRow row: Int) {
        
        recruitCollection.delegate = dataSourceDelegate
        recruitCollection.dataSource = dataSourceDelegate
        recruitCollection.tag = row
        recruitCollection.setContentOffset(recruitCollection.contentOffset, animated:false)
        recruitCollection.reloadData()
    }
    
    var collectionViewOffset: CGFloat {
        get {
            return recruitCollection.contentOffset.x
        }
        
        set {
            recruitCollection.contentOffset.x = newValue
        }
    }
}
