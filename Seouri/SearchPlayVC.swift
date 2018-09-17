//
//  SearchPlayVC.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 15..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import UIKit

class SearchPlayVC: UITableViewController {

    
    var play_ve_list : [VillageEnterpriseVO] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 180.0
        tableView.rowHeight = UITableViewAutomaticDimension
         tableView.tableFooterView = UIView.init(frame: .zero)
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        print("놀거리")
        print(play_ve_list)
    }




    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return play_ve_list.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vo = play_ve_list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        cell.village_ent_image.layer.cornerRadius = 5.0
        cell.txt_bg_img.layer.cornerRadius = 5.0
        cell.village_ent_image.imageFromUrl(gsno(vo.photo), defaultImgPath: "1")
        cell.village_ent_txt.text = gsno(vo.name)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vo = play_ve_list[indexPath.row]
        guard let dvc = storyboard?.instantiateViewController(withIdentifier: "VEDetailVC") as? VEDetailVC else {return}
        print("전달값")
        print(gino(vo.villageEnterpriseId))
        dvc.villageEnterpriseId = gino(vo.villageEnterpriseId)
        dvc.modalTransitionStyle = .crossDissolve
        
        present(dvc, animated: true, completion: nil)
    }
}
