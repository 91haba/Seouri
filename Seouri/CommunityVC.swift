//
//  CommunityVC.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 3..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import UIKit

class CommunityVC: UIViewController {

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
        super.viewDidLoad()
        setNavigationBarItem()
        self.title = "게시판"
        initBtnConfigure()
        initBtnTag()
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
    
    @objc func selected_gu(_ sender : UIButtonBorderRadius){
        
            if sender.tag == 25{
                sender.setTitleColor(UIColor.white, for: .normal)
                sender.backgroundColor = UIColor.init(red: 255.0/255.0, green: 153.0/255.0, blue: 51.0/255.0, alpha: 1.0)
            }
            else{
                sender.setTitleColor(UIColor.white, for: .normal)
                sender.backgroundColor = UIColor(hex:"37B0A6")
            }
            
            guard let dvc = storyboard?.instantiateViewController(withIdentifier: "CommunityPostListVC") as? CommunityPostListVC else {return}
      
            dvc.location = gino(sender.tag)
            let city_txt = gsno(sender.titleLabel?.text).substring(to: gsno(sender.titleLabel?.text).index(gsno(sender.titleLabel?.text).startIndex, offsetBy: 3))
            dvc.city_txt = city_txt
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                    CATransaction.begin()
                    self.navigationController?.pushViewController(dvc, animated: true)
                    CATransaction.setCompletionBlock({
                    () in
                    sender.setTitleColor(UIColor.black, for: .normal)
                    sender.backgroundColor = UIColor.white
                    sender.check = true
                
            })
            CATransaction.commit()
            }
        }//selected gu
}



