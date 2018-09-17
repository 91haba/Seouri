//
//  CourseDetailVC.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 16..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import UIKit


class CourseDetailVC : UIViewController {
    
    
    @IBOutlet var courseDetailTable: UITableView!
    
    var category : Int = 0
    
    
    //북촌데이트 0
    //먹방 쇼핑 1
    //힐리데이트 2
    //커피 문학 3
    //국악 술 4
    
    override func viewDidLoad() {
        courseDetailTable.separatorStyle = .none
        
        courseDetailTable.delegate = self
        courseDetailTable.dataSource = self
        courseDetailTable.estimatedRowHeight = 200.0
        courseDetailTable.rowHeight = UITableViewAutomaticDimension
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CourseDetailVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 169.5
        }
        else if indexPath.row == 1{
            
            return UITableViewAutomaticDimension
        }
        else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            
            let cell = courseDetailTable.dequeueReusableCell(withIdentifier: "CourseDetailHeaderCell") as! CourseDetailHeaderCell
            var header_img = UIImage()
            var description_img = UIImage()
            var title : String = ""
            switch category {
            
            case 0:
                title = "북촌 데이트"
                header_img = #imageLiteral(resourceName: "bookchon_detail")
                description_img = #imageLiteral(resourceName: "bookchon")
            case 1:
                title = "먹방 & 쇼핑"
                header_img = #imageLiteral(resourceName: "eat_detail")
                description_img = #imageLiteral(resourceName: "eat")
            case 2:
                title = "힐링데이트"
                header_img = #imageLiteral(resourceName: "healing_detail")
                description_img = #imageLiteral(resourceName: "healing")
            case 3:
                title = "커피 & 문학"
                header_img = #imageLiteral(resourceName: "coffee_detail")
                description_img = #imageLiteral(resourceName: "coffee-1")
            case 4:
                title = "국악 & 술"
                header_img = #imageLiteral(resourceName: "dance_detail")
                description_img = #imageLiteral(resourceName: "drink")
            default:
                print("error : course category")
            }
            cell.course_title.text = title
            cell.course_main_img.image = header_img
            cell.course_description_img.image = description_img
            cell.course_description_img.layer.shadowPath = UIBezierPath(rect: cell.course_description_img.bounds).cgPath
            cell.course_description_img.layer.shouldRasterize = true
            return cell
        }
        else if indexPath.row == 1{
            let cell = courseDetailTable.dequeueReusableCell(withIdentifier: "CourseDetailContentsCell") as! CourseDetailContentsCell
            
            switch category {
            //북촌데이트
            case 0:
                cell.course_one.text = "북촌공예마을협동조합"
                cell.course_one_contents.text = "북촌공예마을협동조합은 색동복주머니, 면사포, 대모나전국당초문모자합, 한국단청 침구세트, 백자각호 등 한국 전통의 물건을 생산하는 북촌공예마을 사람들이 모인 협동조합입니다. "
                cell.course_two.text = "통인커뮤니티 주식회사"
                cell.course_two_contents.text = "통인시장은 통곡마을과 인왕산을 합쳐서 부른 동명에서 유래하였습니다. 2005년 인정시장으로 정식등록되었고, 2010년 서울시선정 <서울시 문화시장>으로 선정되었습니다."
                cell.course_three.text = "북촌한옥체험살이"
                cell.course_three_contents.text = "북촌은 경복궁과 창덕궁, 종묘 사이에 위치한 곳으로 전통 한옥이 밀집한 서울의 대표적인 전통 주거 지역이며, 많은 사적들과 문화재, 민속 자료가 있어 도심 속의 거리 박물관이라 "
                //먹방쇼핑
                
            case 1:
                cell.course_one.text = "꿈더하기 베이커리"
                cell.course_one_contents.text = "‘꿈더하기’는 영등포 장애인부모회가 발달장애아이들을 위해 만든 희망의 일터입니다. 꿈더하기지원센터는 서울시 주민참여예산으로 설립되었으며 직업교육 프로그램을 확대·운영할 예정입니다."
                cell.course_two.text = "사랑뻥뻥사랑"
                cell.course_two_contents.text = "사랑뻥뻥사랑은 새마을 지역 공동 봉사단체에 기초를 두고 빵을 팔기 위해 고용하는 거싱 아니라 일자리를 창출하기 위해 빵을 파는 마을 기업입니다."
                cell.course_three.text = "협동조합 노느매기"
                cell.course_three_contents.text = "영등포구 당산동에 위치한 재활용가게인 햇살나무에는 중고 책들과 추운 겨울에 입기 좋은 옷들로 가득 차 있습니다. ​계산대에는 EM비누들이 진열되어 있고 그 위 쪽 벽에는 후원자들..."
                //힐링데이트
            case 2:
                cell.course_one.text = "노나매기 단체급식 협동조합"
                cell.course_one_contents.text = "동작구에서는 대부분의 공부방에서 재정과 인력 부족으로 질 낮은 급식이 제공되고 있었습니다. 이러한 문제점을 해소하기 위해 동작구 공부방협의회 정기운영위원회에서 급식 지원의 ..."
                cell.course_two.text = "에너지 슈퍼마켓"
                cell.course_two_contents.text = "성대골 주민들이 만든 마을기업 ‘마을닷살림협동조합’이 운영하는 에너지 슈퍼마켓은 전국에서 유일하게 에너지를 전면에 내걸고 물품을 판매하는 곳입니다. 23㎡ 규모의 작은 매장에..."
                cell.course_three.text = "참손길 협동조합"
                cell.course_three_contents.text = "참손길공동체 협동조합은 시각장애인 전문안마사가 모여 이룬 자생적 협동조합입니다. 그들은 협동조합을 통해 스스로 시각장애인 전문안마사로서 전문성을 키우기 위해 노력합니다. ..."
                //커피문학
            case 3:
                cell.course_one.text = "나눔카페 앤 가게"
                cell.course_one_contents.text = "원두커피판매, 한국인과 동포들에게 필요한 각종 쌍방향 정보 및 배웁니다. (컴퓨터교육, 중국어, 문화체험, 한국역사교육, 출입국관련 업무안내 등) 사회적기업 커피볶에서 제공받는 ..."
                cell.course_two.text = "문화예술협동조합 ‘곁애’"
                cell.course_two_contents.text = "2008년 '배꼽 빠지는 도서관'에서 시작된 '곁애'는 마음의 상처를 깨끗이 치료합니다고 해 '마데카솔공장'이라고도 불립니다. 그 이유는 방황하는 청소년을 문학과 예술을 통해 치유하..."
                cell.course_three.text = "꿈더하기 베이커리"
                cell.course_three_contents.text = "‘꿈더하기’는 영등포 장애인부모회가 발달장애아이들을 위해 만든 희망의 일터입니다. 꿈더하기지원센터는 서울시 주민참여예산으로 설립되었으며 직업교육 프로그램을 확대·운영할 예정입니다."
                //국악 술
            case 4:
                cell.course_one.text = "국악나루"
                cell.course_one_contents.text = "국악나루가 긴 준비를 마치고 예술가와 시민이 함께하는 문화 예술 협동조합으로거듭 납니다. 1997년 자주문화 운동 민족문화지킴이 천하대장군, 2007년 더많은 이들과 함께 하고자 ..."
                cell.course_two.text = "홍스공방"
                cell.course_two_contents.text = "홍스공방은 2009년부터 프랑스식 가죽공예 교육을 하고 있는 가죽공예 공방 입니다. 홍스공방은 '화이'와 '신의 손'등 영화와 드라마의 소품 제작에도 참여했으며 외국인 관광안내사이트..."
                cell.course_three.text = "놀자씨씨"
                cell.course_three_contents.text = "지역문화 생태계 활성화를 위한 예비사회적기업 ‘놀자씨씨’ 분명 카페는 아닌 것 같은데 동네 학생들과 주부들이 자유롭게 드나들며 커피를 마시고, 밤에는 삼삼오오 사람들이 모여 ..."
                
            default:
                print("Error:course")
            }
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    
    
}
