//
//  SeouriSearchControllerVC.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 14..
//  Copyright © 2017년 SOPT. All rights reserved.
//
import UIKit
import Foundation
import SJSegmentedScrollView


class SeouriSearchControllerVC : SJSegmentedViewController {
    
    //1. 놀거리
    //2. 구경거리
    //3. 먹거리
    //4. 체험거리
    //25 전체
    
    var selectedSegment: SJSegmentTab?

    var location : Int?
    var VElist : [VillageEnterpriseVO] = []
    var play_list : [VillageEnterpriseVO] = []
    var spectacle_list : [VillageEnterpriseVO] = []
    var food_list : [VillageEnterpriseVO] = []
    var experience_list : [VillageEnterpriseVO] = []
    
    override func viewDidLoad() {
       
        
        
        let model = SearchModel(self)
        model.getVElistWithLocation(location: gino(location))
        startLoading()

    }
    
    func initView(){
        
        setNavigationBarItem()
        //서버에 디바이스 토큰 등록
        
        guard let storyboard = self.storyboard else{return}
        
        let headerView = storyboard.instantiateViewController(withIdentifier: "SearchHeaderVC")
        let allVC = storyboard.instantiateViewController(withIdentifier: "SearchAllVC") as! SearchAllVC
        allVC.title = "전체"
        allVC.all_ve_list = self.VElist
        

        let playVC = storyboard.instantiateViewController(withIdentifier: "SearchPlayVC") as! SearchPlayVC
        playVC.title = "놀거리"
        playVC.play_ve_list = play_list
        
        let foodVC = storyboard.instantiateViewController(withIdentifier: "SearchFoodVC") as! SearchFoodVC
        foodVC.title = "먹거리"
        foodVC.food_ve_list = self.food_list
        
        let spectacleVC = storyboard.instantiateViewController(withIdentifier: "SearchSpectacleVC") as! SearchSpectacleVC
        spectacleVC.title = "구경거리"
        spectacleVC.spectacle_ve_list = spectacle_list
        
        let experienceVC = storyboard.instantiateViewController(withIdentifier: "SearchExperienceVC") as! SearchExperienceVC
        experienceVC.title = "체험거리"
        experienceVC.experience_ve_list = self.experience_list
        
        
        headerViewHeight = 64.0
        headerViewController = headerView
        segmentControllers = [
            
            allVC,
            playVC,
            foodVC,
            spectacleVC,
            experienceVC
            
        ]
        
        selectedSegmentViewHeight = 5.0
        segmentTitleColor = .lightGray
        selectedSegmentViewColor = .init(hex: "F49E47")
        segmentShadow = SJShadow.light()
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
        delegate = self

        super.viewDidLoad()
        self.view.layoutIfNeeded()
        print("슈퍼뷰로오드")
        
    }
}

extension SeouriSearchControllerVC : NetworkCallback{
    
    func networkResult(resultData: Any, apiCode: String) {
        
        if apiCode == "3-2-location"{
            stopLoading()
            VElist = resultData as! [VillageEnterpriseVO]
            
            for ve in VElist {
                let category : String = gsno(ve.category)
                switch category {
                case "1":
                    play_list.append(ve)
                case "2":
                    spectacle_list.append(ve)
                case "3":
                    food_list.append(ve)
                case "4":
                    experience_list.append(ve)
                default:
                    print("error : category number")
                }
            }
            
            print(VElist)
            print("슈퍼뷰로오드되라")
            initView()
        }//apiCode
        else if apiCode == "3-2-all"{
            stopLoading()
            
            VElist = resultData as! [VillageEnterpriseVO]
            
            for ve in VElist {
                let category : String = gsno(ve.category)
                switch category {
                case "1":
                    play_list.append(ve)
                    print("dlfdlfdlf")
                    print(ve.villageEnterpriseId)
                case "2":
                    spectacle_list.append(ve)
                    print("dlfdlfdlf2")
                    print(ve.villageEnterpriseId)
                case "3":
                    food_list.append(ve)
                    print("dlfdlfdlf3")
                    print(ve.villageEnterpriseId)
                case "4":
                    experience_list.append(ve)
                    print("dlfdlfdlf4")
                    print(ve.villageEnterpriseId)
                default:
                    print("error : category number")
                }
            }
            print(VElist)
            print("슈퍼뷰로오드되라")
            initView()
        }//3-2-all
    }
}


extension SeouriSearchControllerVC: SJSegmentedViewControllerDelegate {
    
    func didMoveToPage(_ controller: UIViewController, segment: SJSegmentTab?, index: Int) {
        
        if selectedSegment != nil {
            selectedSegment?.titleColor(.lightGray)
        }

        if segments.count > 0 {
            selectedSegment = segments[index]
            selectedSegment?.titleColor(.init(hex: "FBD147"))
        }
    }
}
