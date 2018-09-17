//
//  LeftVC.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 3..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import UIKit
import MessageUI
import SlideMenuControllerSwift
import Kingfisher


class LeftVC : UIViewController,LeftMenuProtocol {

    
    @IBOutlet var menuTable: UITableView!
    let ud = UserDefaults.standard
    var menus = ["홈","검색","추천코스","커뮤니티"]
    var mainVC: UIViewController!
    var searchVC: UIViewController!
    var courseVC: UIViewController!
    var communityVC: UIViewController!
    var inquireVC : UIViewController!
    var mypageVC : UIViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        menuTable.delegate = self
        menuTable.dataSource = self
        
         self.menuTable.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
      
        let search_board = UIStoryboard(name: "Search", bundle: nil)
        let course_board = UIStoryboard(name: "Course", bundle: nil)
        let community_board = UIStoryboard(name: "Community", bundle: nil)
        let inquire_board = UIStoryboard(name: "Inquire", bundle: nil)
       
        
        let MainVC = storyboard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        self.mainVC = UINavigationController(rootViewController: MainVC)
        let SearchVC = search_board.instantiateViewController(withIdentifier: "SelectLocationVC") as! SelectLocationVC
        self.searchVC = UINavigationController(rootViewController: SearchVC)
        let CourseVC = course_board.instantiateViewController(withIdentifier: "CourseVC") as! CourseVC
        self.courseVC = UINavigationController(rootViewController: CourseVC)
        let CommunityVC = community_board.instantiateViewController(withIdentifier: "CommunityVC") as! CommunityVC
        self.communityVC = UINavigationController(rootViewController : CommunityVC)
        let InquireVC = inquire_board.instantiateViewController(withIdentifier: "InquireVC") as! InquireVC
        self.inquireVC = UINavigationController(rootViewController: InquireVC)
        let Mypage = storyboard.instantiateViewController(withIdentifier: "MypageVC") as! MypageVC
        self.mypageVC = UINavigationController(rootViewController: Mypage)
      //  self.menuTable.registerCellClass(BaseTableViewCell.self)
        
        self.menuTable.estimatedRowHeight = 44.0
        self.menuTable.rowHeight = UITableViewAutomaticDimension
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillLayoutSubviews() {
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func changeViewController(_ menu: LeftMenu) {
        
        switch menu {
        case .홈:
            self.title = "서우리"
            self.slideMenuController()?.changeMainViewController(self.mainVC, close: true)
       
            menuTable.deselectRow(at: IndexPath(row:0, section:0), animated: true)
        case .검색:
            self.title = "검색"
            let search_board = UIStoryboard(name: "Search", bundle: nil)
            guard let svc = search_board.instantiateViewController(withIdentifier: "SelectLocationVC") as? SelectLocationVC else{return}
            svc.modalTransitionStyle = .crossDissolve
            self.present(svc,animated:true){
                self.closeLeft()
            }
            menuTable.deselectRow(at: IndexPath(row:1, section:0), animated: true)
        case .추천코스:
            self.title = "추천코스"
            print("추천추천코오스")
            self.slideMenuController()?.changeMainViewController(self.courseVC, close: true)
             menuTable.deselectRow(at: IndexPath(row:2, section:0), animated: true)
        case .커뮤니티:
            self.title = "커뮤니티"
            self.slideMenuController()?.changeMainViewController(self.communityVC, close: true)
          menuTable.deselectRow(at: IndexPath(row:3, section:0), animated: true)
  
        case .문의하기:
            print("문읳라")
           menuTable.deselectRow(at: IndexPath(row:4, section:0), animated: true)
            self.slideMenuController()?.changeMainViewController(self.inquireVC, close: true)
         
        }
        
    }//changeViewController
}

extension LeftVC : UITableViewDelegate,UITableViewDataSource{

    func goToMypage(){

        self.slideMenuController()?.changeMainViewController(self.mypageVC, close: true)
    
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 135.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = menuTable.dequeueReusableCell(withIdentifier: "DrawbarHeaderCell") as! DrawbarHeaderCell
        cell.mypage_btn.addTarget(self, action: #selector(goToMypage), for: .touchUpInside)
       
        print("플필이미지")
        print(gsno(ud.string(forKey: "profile_img")))
        if let profile_img_url = URL(string: gsno(ud.string(forKey: "profile_img"))) {
            KingfisherManager.shared.downloader.downloadImage(with: profile_img_url, options: nil, progressBlock: nil){
                
                (image, error, imageURL, data) in
                print("드루와드루와")
                if let tmp_image = image {
                    print("드루와드루와2")
                    cell.mypage_btn.setImage(tmp_image, for: .normal)
                    
                }
                else{
                    cell.mypage_btn.setImage(#imageLiteral(resourceName: "me"), for: .normal)
                }
                
            }
            
        }
            
        else{
            cell.mypage_btn.setImage(#imageLiteral(resourceName: "me"), for: .normal)
        }
        cell.mypage_btn.layer.cornerRadius = cell.mypage_btn.frame.width / 2
        cell.mypage_btn.clipsToBounds = true
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        self.menuTable.separatorStyle = UITableViewCellSeparatorStyle.none
        
        if let menu = LeftMenu(rawValue: indexPath.row) {

            let cell = tableView.dequeueReusableCell(withIdentifier: "DrawbarMenuCell", for: indexPath) as! DrawbarMenuCell
            
            switch menu{
                
            case .홈:
                cell.menu.text = "홈"
                cell.menuImage.image = #imageLiteral(resourceName: "home")
            case .검색:
                cell.menu.text = "검색"
                cell.menuImage.image = #imageLiteral(resourceName: "search-2")
            case .추천코스:
                cell.menu.text = "추천코스"
                cell.menuImage.image = #imageLiteral(resourceName: "recommand")
            case .커뮤니티:
                cell.menu.text = "커뮤니티"
                cell.menuImage.image = #imageLiteral(resourceName: "community")
            case .문의하기:
                cell.menu.text = "문의하기"
                cell.menuImage.image = #imageLiteral(resourceName: "ask")
            }
            
            return cell
        }
            
            
        else{
            return UITableViewCell()
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

}

extension LeftVC {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.menuTable == scrollView {
            
        }
    }
}
