//
//  SearchHeaderVC.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 15..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import UIKit
class SearchHeaderVC : UIViewController{
    
    @IBOutlet var serach_textField: UITextField!
    @IBOutlet var search_btn: UIButton!
    @IBOutlet var location_btn: UIButton!
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        search_btn.addTarget(self, action: #selector(search_ve(_:)), for: .touchUpInside)
    }
    
    @objc func search_ve(_ sender : UIButton){
        let word = gsno(serach_textField.text)
        let model = SearchModel(self)
        serach_textField.resignFirstResponder()
        model.searchSpecificVe(name : word)
        startLoading()
    }
    
}

extension SearchHeaderVC : NetworkCallback {
    
    func networkResult(resultData: Any, apiCode: String) {
        stopLoading()
        if apiCode == "3-1"{
            let ve  = resultData as! VillageEnterpriseVO
            let ve_id = gino(ve.villageEnterpriseId)
            guard let dvc = storyboard?.instantiateViewController(withIdentifier: "VEDetailVC") as? VEDetailVC else {return}
            dvc.villageEnterpriseId = ve_id
            dvc.modalTransitionStyle = .crossDissolve
            present(dvc, animated: true, completion: nil)
        }
            
        else if apiCode == "3-3-Not exist popup"{
            
            SweetAlert().showAlert("Seouri", subTitle: "검색결과가 존재하지 않습니다", style: .warning, buttonTitle: "확인", buttonColor: UIColor(hex: "37B0A6"))
        }
    }
}
