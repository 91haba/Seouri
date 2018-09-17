//
//  PostDetailCell.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 26..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import UIKit

class PostDetailCell: UITableViewCell {
    @IBOutlet var writer_img: UIImageView!
    @IBOutlet var writer: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var content: UITextView!
    @IBOutlet var photo_collection: UICollectionView!
    @IBOutlet var more_see: UIButton!
    
    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDataSource & UICollectionViewDelegate>
        (dataSourceDelegate: D, forRow row: Int) {
        
        photo_collection.delegate = dataSourceDelegate
        photo_collection.dataSource = dataSourceDelegate
        photo_collection.tag = row
        photo_collection.reloadData()
    }
    
    var collectionViewOffset: CGFloat {
        get {
            return photo_collection.contentOffset.x
        }
        
        set {
            photo_collection.contentOffset.x = newValue
        }
    }
    
}
