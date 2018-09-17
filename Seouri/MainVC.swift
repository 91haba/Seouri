//
//  ViewController.swift
//  Seouri
//
//  Created by 하태경 on 2017. 9. 19..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import SJSegmentedScrollView
import Floaty
import ImageSlideshow
import GoogleMaps
import GooglePlaces
import Kingfisher
import SafariServices


class MainVC : UIViewController, UIGestureRecognizerDelegate{
    
    @IBOutlet var mainTable: UITableView!
    
    var homeVO : HomeVO?
    
    var locationManager = CLLocationManager()
    var currnetLocation : CLLocation?
    var mapView : GMSMapView!
    var placesClient : GMSPlacesClient!
    var zoomLevel : Float = 15.0
    // An array to hold the list of likely places.
    var likelyPlaces: [GMSPlace] = []
    
    // The currently selected place.
    var selectedPlace: GMSPlace?
    let defaultLocation = CLLocation(latitude: -33.869405, longitude: 151.199)
    
    
    var header_photo_list : [ImageSource] = []
    var header_page : Int = 0
    
    var currentMyLocation : (Double,Double) = (37.674187000,127.059169000){
        didSet{
            print("디드셋 안으로")
            let model = HomeModel(self)
            model.getHomeInfo(userLat: Double(currentMyLocation.0), userLng: Double(currentMyLocation.1))
        }
    }
    var titleImg : UIImage!
    var titleImgView: UIImageView!

    override func viewDidLoad() {

        
        setNavigationBarItem()
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.estimatedRowHeight = 200.0
        mainTable.rowHeight = UITableViewAutomaticDimension
        mainTable.separatorStyle = .none

        self.titleImg = #imageLiteral(resourceName: "logo")
        self.titleImgView = UIImageView(image: self.titleImg)
        self.titleImgView.frame = CGRect(x: 0, y: 0, width: 74, height: 32)
        self.navigationItem.titleView = self.titleImgView
        self.view.layoutIfNeeded()
        self.mainTable.layoutIfNeeded()
        
         initGoogleMaps()
        let model = HomeModel(self)
        print("viewdidload")
        model.getHomeInfo(userLat: currentMyLocation.0, userLng: currentMyLocation.1)
        startLoading()
      
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        initGoogleMaps()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.view.layoutIfNeeded()
        self.mainTable.reloadData()
        self.mainTable.layoutIfNeeded()
    }
    func initGoogleMaps(){
       
        // Initialize the location manager.
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
    
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        placesClient = GMSPlacesClient.shared()
        
        listLikelyPlaces()
        
        // Create a map.
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                              longitude: defaultLocation.coordinate.longitude,
                                              zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true

        
       
    }
    
    @objc func didTap(_ sender : UITapGestureRecognizer){
        
        if let cell = mainTable.cellForRow(at: IndexPath(row: 0, section: 0)) as? MainHeaderCell{
            let fullScreenController = cell.headerView.presentFullScreenController(from: self)
            fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
        }
    }//didTap
    
    @objc func clicked_noti(_ sender : UIButton){
        
        let index = sender.tag
        if let url = URL(string:gsno(homeVO?.villageinformation[index].inforUrl)){

            
        UIApplication.shared.openURL(url)
        }
       
        
    }//clicked noti
    
    @objc func popupMenu(_ sender : UIBarButtonItem){
        let seouriTransitionDelegate = SeouriTransitionDelegate(height: 330 )
        self.transitioningDelegate = seouriTransitionDelegate
        let pvc = self.storyboard!.instantiateViewController(withIdentifier: "PopupVC") as! PopupVC
        pvc.modalPresentationStyle = .custom
        pvc.transitioningDelegate = seouriTransitionDelegate
        
        present(pvc,animated:true)
    }
    
    @objc func clickedThisWeekVE(_ sender : UITapGestureRecognizer? = nil){
     //   let img_view = sender.view as! UIImageView
        print("탭드인덱스")
        let tappedImage = sender?.view as! UIImageView
        let index : Int = (sender!.view?.tag)!
        
        print(index)
        let ve = homeVO?.weekvillageEnterprise[index]
        let search_board = UIStoryboard(name: "Search", bundle: nil)
        guard let dvc = search_board.instantiateViewController(withIdentifier: "VEDetailVC") as? VEDetailVC else{return}
        dvc.modalTransitionStyle = .crossDissolve
        dvc.villageEnterpriseId = gino(ve?.villageEnterpriseId)
        present(dvc, animated: true, completion: nil)
    }
    
    @objc func registerRecruiting(_ sender : UIButton){
        
        let seouriTransitionDelegate = SeouriTransitionDelegate(height: 430)
        self.transitioningDelegate = seouriTransitionDelegate
        let pvc = self.storyboard!.instantiateViewController(withIdentifier: "PopupVC") as! PopupVC
        pvc.modalPresentationStyle = .custom
        pvc.transitioningDelegate = seouriTransitionDelegate
        
        present(pvc,animated:true)
    
    }
   
    
}


extension MainVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0{
            return UIScreen.main.bounds.height / 3.3
        }
        else if indexPath.row == 1{
            
            return 326.0
        }
        
        else if indexPath.row == 4{
            return 190
        }
        else{
            return UITableViewAutomaticDimension
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let first_weekVillageVO = homeVO?.weekvillageEnterprise[0]
        let second_weekVillageVO = homeVO?.weekvillageEnterprise[1]
       //헤더
        if indexPath.row == 0{
            
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
            recognizer.delegate = self
            
            let header_cell = mainTable.dequeueReusableCell(withIdentifier: "MainHeaderCell") as! MainHeaderCell
            header_cell.headerView.backgroundColor = UIColor.clear
            header_cell.headerView.contentScaleMode = .scaleAspectFill
            header_cell.headerView.currentPageChanged = {
                page in
                self.header_page = page
            }
            
            header_cell.headerView.setImageInputs(header_photo_list)
            header_cell.headerView.addGestureRecognizer(recognizer)
            header_cell.headerView.tintColor = UIColor.red
            return header_cell
        }
        //이주의 마을기업
        else if indexPath.row == 1{
            
            let image_cell = mainTable.dequeueReusableCell(withIdentifier: "ThisWeekImageCell") as! ThisWeekImageCell
            let this_week_image_tap_1 = UITapGestureRecognizer(target: self, action: #selector(clickedThisWeekVE(_:)))
            let this_week_image_tap_2 = UITapGestureRecognizer(target: self, action: #selector(clickedThisWeekVE(_:)))

            
            image_cell.village_ent_image.layer.cornerRadius = 5.0
            image_cell.village_ent_txt_bg.layer.cornerRadius = 5.0
            
            print("헤더이미지 111")
            print(first_weekVillageVO?.image)
            print(gsno(first_weekVillageVO?.image))
            image_cell.village_ent_image.imageFromUrl(gsno(first_weekVillageVO?.image), defaultImgPath: "1")
            image_cell.village_ent_txt.text = gsno(first_weekVillageVO?.name)
            image_cell.village_ent_image.tag = 0
            image_cell.village_ent_image.isUserInteractionEnabled = true
            image_cell.village_ent_image.addGestureRecognizer(this_week_image_tap_1)
            
            print("헤더이미지 222")
            print(gsno(second_weekVillageVO?.image))
            image_cell.village_ent_image_2.imageFromUrl(gsno(second_weekVillageVO?.image), defaultImgPath: "1")
            image_cell.village_ent_txt_2.text = gsno(second_weekVillageVO?.name)
            image_cell.village_ent_image_2.tag = 1
            image_cell.village_ent_image_2.isUserInteractionEnabled = true
            image_cell.village_ent_image_2.addGestureRecognizer(this_week_image_tap_2)
 

            this_week_image_tap_1.delegate = self
            this_week_image_tap_2.delegate = self
            
            return image_cell
        }
        else if indexPath.row == 2{
            let nearby_ve_cell = mainTable.dequeueReusableCell(withIdentifier: "NearbyVECell") as! NearbyVECell
            let nearbyVE : String = gsno(homeVO?.distanceRec?.name)
            nearby_ve_cell.nearbyVillageEnterprise.text = nearbyVE
            return nearby_ve_cell
        }
        else if indexPath.row == 3{
            
            let info_cell = mainTable.dequeueReusableCell(withIdentifier: "ThisWeekInfoCell") as! ThisWeekInfoCell
            let underlieBtnTitle : [String : Any] = [
                NSFontAttributeName : UIFont(name: "BBTreeGL", size: 15),
                NSForegroundColorAttributeName : UIColor.init(red: 255.0/255.0, green: 153.0/255.0, blue: 51.0/255.0, alpha: 1.0),
               NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue
            ]
            
            info_cell.first_noti.tag = 0
            info_cell.second_noti.tag = 1
            info_cell.third_noti.tag = 2
            info_cell.fourth_noti.tag = 3
            info_cell.first_noti.addTarget(self, action: #selector(clicked_noti(_:)), for: .touchUpInside)
            info_cell.second_noti.addTarget(self, action: #selector(clicked_noti(_:)), for: .touchUpInside)
            info_cell.third_noti.addTarget(self, action: #selector(clicked_noti(_:)), for: .touchUpInside)
            info_cell.fourth_noti.addTarget(self, action: #selector(clicked_noti(_:)), for: .touchUpInside)
            print("$$$!@#")
            print(homeVO?.villageinformation[0].comment)
            
              let noti_1 = NSAttributedString(string: gsno(homeVO?.villageinformation[0].comment), attributes: underlieBtnTitle)
              let noti_2 = NSAttributedString(string: gsno(homeVO?.villageinformation[1].comment), attributes: underlieBtnTitle)
              let noti_3 = NSAttributedString(string: gsno(homeVO?.villageinformation[2].comment), attributes: underlieBtnTitle)
              let noti_4 = NSAttributedString(string: gsno(homeVO?.villageinformation[3].comment), attributes: underlieBtnTitle)
            
             info_cell.first_noti.setAttributedTitle(noti_1, for: .normal)
             info_cell.second_noti.setAttributedTitle(noti_2, for: .normal)
             info_cell.third_noti.setAttributedTitle(noti_3, for: .normal)
             info_cell.fourth_noti.setAttributedTitle(noti_4, for: .normal)
           /*  info_cell.first_noti.setTitle(noti_1, for: .normal)
             info_cell.second_noti.setTitle(noti_2, for: .normal)
             info_cell.third_noti.setTitle(noti_3, for: .normal)
             info_cell.fourth_noti.setTitle(noti_4, for: .normal)*/
            
            
            return info_cell
        }
        else if indexPath.row == 4{
            print("구인정보")
            
            let recruit_cell = mainTable.dequeueReusableCell(withIdentifier: "VERecruitingCell") as! VERecruitingCell
            recruit_cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
            recruit_cell.recruitCollection.reloadData()
            recruit_cell.registerRecruting.addTarget(self, action: #selector(registerRecruiting(_:)), for: .touchUpInside)
            return recruit_cell
        }
        else if indexPath.row == 5{
            print("소개셀")
            let introduce_cell = mainTable.dequeueReusableCell(withIdentifier: "VEIntroduceCell") as! VEIntroduceCell
            return introduce_cell
        }
        else {
            return UITableViewCell()
        }
        
    }//cellForRow
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 2{
            let nearbyVE_id = gino(homeVO?.distanceRec?.villageEnterpriseId)
            let search_board = UIStoryboard(name: "Search", bundle: nil)
            guard let dvc = search_board.instantiateViewController(withIdentifier: "VEDetailVC") as? VEDetailVC else{return}
            dvc.modalTransitionStyle = .crossDissolve
            dvc.villageEnterpriseId = nearbyVE_id
            present(dvc, animated: true){
                () in
                self.mainTable.deselectRow(at: indexPath, animated: true)
            }
        }
            
        else if indexPath.row == 3{
            var jobInfoVO = homeVO?.jobinformation[indexPath.row]
            if let url = URL(string: gsno(jobInfoVO?.joburl)){
                UIApplication.shared.openURL(url)
            }
        }//indexPath 3, 알림당
    }//didselect

    
}

extension MainVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 167, height: 109)
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("코올렉션")
        print(gino(homeVO?.jobinformation.count))
        return gino(homeVO?.jobinformation.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let job_info_cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JobInfoCell",for: indexPath) as! JobInfoCell
        var jobInfoVO = homeVO?.jobinformation[indexPath.item]
        job_info_cell.title.text = gsno(jobInfoVO?.name)
        //job_info_cell.title_img.imageFromUrl(gsno(jobInfoVO.), defaultImgPath: "1")
        
        print("셀폴아이템")
        print( gsno(jobInfoVO?.address))
        
        job_info_cell.location.text = gsno(jobInfoVO?.address)
        job_info_cell.payment.text = gsno(jobInfoVO?.pay)
        job_info_cell.title_img.image = #imageLiteral(resourceName: "shoes")
        job_info_cell.work_hour.text = gsno(jobInfoVO?.time)
        job_info_cell.info_view.layer.borderWidth = 2.0
        job_info_cell.info_view.layer.cornerRadius = 5.0
        job_info_cell.info_view.layer.borderColor = UIColor(hex: "37B0A6").cgColor
        
        return job_info_cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension MainVC : NetworkCallback {
    
    func networkResult(resultData: Any, apiCode: String) {
        
        stopLoading()
 
        if apiCode == "2-1"{
            self.homeVO = resultData as! HomeVO
         
            print("근처 마을기업 정보")
            print(self.homeVO?.distanceRec?.address)
           print(self.homeVO?.distanceRec?.name)
        
            if let photo_list = homeVO?.poster as? [PostImageVO]{
                
                mainloop : for photo in photo_list{
                    //baseURL/uploads/mentors/mentorPhotoIntroduce
                    //위 유알엘에서 가져오면됨
                    //let cnt : Int = 0
                    
                    let imageSourceURL = gsno(photo.image)
                    guard let url = URL(string:imageSourceURL) else {return}
            
                    ImageDownloader.default.downloadImage(with: url, options: [], progressBlock: nil){
                        (image, error, url, data) in
                        print("사진유알엘2")
                        print(url)
                        
                        if let header_photo = image as? UIImage {
                            
                            // self.mentor_photo_list.append(mentor_photo)
                            self.header_photo_list.append(ImageSource(image:header_photo))
                            
                        }//if let mentor_photo
                         self.mainTable.reloadData()
                       
                    }//ImageDownloader
                }//for
            }//if let
        }
        self.mainTable.reloadData()
    }//networkResult
}

extension MainVC : CLLocationManagerDelegate, GMSMapViewDelegate{
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location: CLLocation = locations.last!
        
        print("Location: \(location)")
        guard let myLat : Double = location.coordinate.latitude as? Double else {return}
        guard let myLng : Double = location.coordinate.longitude as? Double else {return}
        currentMyLocation.0 = myLat
        currentMyLocation.1 = myLng


        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
        
        listLikelyPlaces()
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    
    // Populate the array with the list of likely places.
    func listLikelyPlaces() {
        // Clean up from previous sessions.
        likelyPlaces.removeAll()
        
        placesClient.currentPlace(callback: { (placeLikelihoods, error) -> Void in
            if let error = error {
                // TODO: Handle the error.
                print("Current Place error: \(error.localizedDescription)")
                return
            }
            
            // Get likely places and add to the list.
            if let likelihoodList = placeLikelihoods {
                for likelihood in likelihoodList.likelihoods {
                    let place = likelihood.place
                    self.likelyPlaces.append(place)
                    }
                }
            })
        }
}


extension MainVC : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }

}

