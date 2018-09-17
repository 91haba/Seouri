//
//  SelectLocationVC.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 23..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import UIKit

class SelectLocationVC : UIViewController{
    
    
    
    @IBOutlet var searchTxt: UITextField!
    @IBOutlet var searchBtn: UIButton!
    
    @IBOutlet var all: UIButtonBorderRadius!
    
    @IBOutlet var gangnam_gu: UIButtonBorderRadius!
    
    @IBOutlet var gangseo_gu: UIButtonBorderRadius!
    
    @IBOutlet var guro_gu: UIButtonBorderRadius!
    
    @IBOutlet var dobong_gu: UIButtonBorderRadius!
    
    @IBOutlet var mapo_gu: UIButtonBorderRadius!
    
    @IBOutlet var sungdong_gu: UIButtonBorderRadius!
    
    @IBOutlet var yangcheon_gu: UIButtonBorderRadius!
    
    @IBOutlet var eunpyeong_gu: UIButtonBorderRadius!
    
    @IBOutlet var joongrang_gu: UIButtonBorderRadius!
    
    @IBOutlet var gangdong_gu: UIButtonBorderRadius!
    
    @IBOutlet var gwanak_gu: UIButtonBorderRadius!
    
    @IBOutlet var geumcheon_gu: UIButtonBorderRadius!
    
    @IBOutlet var dongdaemoon_gu: UIButtonBorderRadius!
    
    @IBOutlet var seodaemoon_gu: UIButtonBorderRadius!
    
    @IBOutlet var yeongdeungpo_gu: UIButtonBorderRadius!
    
    @IBOutlet var sungbook_gu: UIButtonBorderRadius!
    
    @IBOutlet var jongro_gu: UIButtonBorderRadius!
    
    @IBOutlet var gangbook_gu: UIButtonBorderRadius!
    
    @IBOutlet var gwangjin_gu: UIButtonBorderRadius!
    
    @IBOutlet var nowon_gu: UIButtonBorderRadius!
    
    @IBOutlet var dongjak_gu: UIButtonBorderRadius!
    
    @IBOutlet var seocho_gu: UIButtonBorderRadius!
    
    @IBOutlet var songpa_gu: UIButtonBorderRadius!
    
    @IBOutlet var yongsan_gu: UIButtonBorderRadius!
    
    @IBOutlet var joong_gu: UIButtonBorderRadius!
    
    @IBOutlet var sv_1: UIStackView!
    @IBOutlet var sv_2: UIStackView!
    @IBOutlet var sv_3: UIStackView!
    
    var btn_index : Int = -1

    override func viewDidLoad() {
        self.title = "검색"
        setNavigationBarItem()
        initBtnConfigure()
        initBtnTag()
        searchBtn.addTarget(self, action: #selector(search_ve(_:)), for: .touchUpInside)
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func initBtnConfigure(){
        
        all.addTarget(self, action: #selector(selected_gu(_:)), for: .touchUpInside)
        gangnam_gu.addTarget(self, action: #selector(selected_gu(_:)), for: .touchUpInside)
        gangseo_gu.addTarget(self, action: #selector(selected_gu(_:)), for: .touchUpInside)
        guro_gu.addTarget(self, action: #selector(selected_gu(_:)), for: .touchUpInside)
        dobong_gu.addTarget(self, action: #selector(selected_gu(_:)), for: .touchUpInside)
        mapo_gu.addTarget(self, action: #selector(selected_gu(_:)), for: .touchUpInside)
        sungdong_gu.addTarget(self, action: #selector(selected_gu(_:)), for: .touchUpInside)
        yangcheon_gu.addTarget(self, action: #selector(selected_gu(_:)), for: .touchUpInside)
        eunpyeong_gu.addTarget(self, action: #selector(selected_gu(_:)), for: .touchUpInside)
        joongrang_gu.addTarget(self, action: #selector(selected_gu(_:)), for: .touchUpInside)
        gangdong_gu.addTarget(self, action: #selector(selected_gu(_:)), for: .touchUpInside)
        gwanak_gu.addTarget(self, action: #selector(selected_gu(_:)), for: .touchUpInside)
        geumcheon_gu.addTarget(self, action: #selector(selected_gu(_:)), for: .touchUpInside)
        dongdaemoon_gu.addTarget(self, action: #selector(selected_gu(_:)), for: .touchUpInside)
        seodaemoon_gu.addTarget(self, action: #selector(selected_gu(_:)), for: .touchUpInside)
        sungbook_gu.addTarget(self, action: #selector(selected_gu(_:)), for: .touchUpInside)
        yeongdeungpo_gu.addTarget(self, action: #selector(selected_gu(_:)), for: .touchUpInside)
        jongro_gu.addTarget(self, action: #selector(selected_gu(_:)), for: .touchUpInside)
        gangbook_gu.addTarget(self, action: #selector(selected_gu(_:)), for: .touchUpInside)
        gwangjin_gu.addTarget(self, action: #selector(selected_gu(_:)), for: .touchUpInside)
        nowon_gu.addTarget(self, action: #selector(selected_gu(_:)), for: .touchUpInside)
        dongjak_gu.addTarget(self, action: #selector(selected_gu(_:)), for: .touchUpInside)
        seocho_gu.addTarget(self, action: #selector(selected_gu(_:)), for: .touchUpInside)
        songpa_gu.addTarget(self, action: #selector(selected_gu(_:)), for: .touchUpInside)
        yongsan_gu.addTarget(self, action: #selector(selected_gu(_:)), for: .touchUpInside)
        joong_gu.addTarget(self, action: #selector(selected_gu(_:)), for: .touchUpInside)
        
        for btn in sv_1.subviews{
            
            var tag : Int = 0
            btn.tag = tag
            tag+=1
            
        }
    }
    
    func initBtnTag(){
        all.tag = 25
        
        gangnam_gu.tag = 0
        gangseo_gu.tag = 1
        guro_gu.tag = 2
        dobong_gu.tag = 3
        mapo_gu.tag = 4
        sungdong_gu.tag = 5
        yangcheon_gu.tag = 6
        eunpyeong_gu.tag = 7
        joongrang_gu.tag = 8
        gangdong_gu.tag = 9
        gwanak_gu.tag = 10
        geumcheon_gu.tag = 11
        dongdaemoon_gu.tag = 12
        seodaemoon_gu.tag = 13
        sungbook_gu.tag = 14
        yeongdeungpo_gu.tag = 15
        jongro_gu.tag = 16
        gangbook_gu.tag = 17
        gwangjin_gu.tag = 18
        nowon_gu.tag = 19
        dongjak_gu.tag = 20
        seocho_gu.tag = 21
        songpa_gu.tag = 22
        yongsan_gu.tag = 23
        joong_gu.tag = 24
    }
    
    @objc func search_ve(_ sender : UIButton){
        let word = gsno(searchTxt.text)
        let model = SearchModel(self)
        searchTxt.resignFirstResponder()
        model.searchSpecificVe(name : word)
        startLoading()
    }
    
    @objc func selected_gu(_ sender : UIButtonBorderRadius){
        

        if sender.check{
            
            btn_index = sender.tag
            print("sender.tag")
            print(sender.tag)
            sender.setTitleColor(UIColor.black, for: .normal)
            sender.backgroundColor = UIColor.white
            sender.check = false

        }
        else{
  
            sender.setTitleColor(UIColor.white, for: .normal)
            sender.backgroundColor = UIColor(hex:"37B0A6")
            guard let dvc = storyboard?.instantiateViewController(withIdentifier: "SeouriSearchControllerVC") as? SeouriSearchControllerVC else {return}
            dvc.location = gino(sender.tag)
            dvc.modalTransitionStyle = .crossDissolve
            present(dvc, animated: true){
                
                (_) in
                 sender.check = true
                sender.setTitleColor(UIColor.black, for: .normal)
                sender.backgroundColor = UIColor.white
                
               
            }
        }
    }
}

extension SelectLocationVC : NetworkCallback{
    
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
        else if apiCode == "3-3"{
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
