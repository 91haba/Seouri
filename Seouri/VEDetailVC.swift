//
//  SearchDetailVC.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 21..
//  Copyright © 2017년 SOPT. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker

class VEDetailVC : UIViewController {
    
    var locationManager = CLLocationManager()
    var villageEnterpriseId : Int = 0
    var collection_photo_list : [String] = []
    var mapView : GMSMapView = GMSMapView(frame: CGRect(x: 0, y: 0, width: 375.0, height: 200))
    var ve_location : CLLocation = CLLocation()
    @IBOutlet var detail: UITextView!
    @IBOutlet var photo: UIImageView!
    @IBOutlet var photo_collection: UICollectionView!
    @IBOutlet var detailTable: UITableView!
    @IBOutlet var ve_name: UILabel!
   // @IBOutlet var textToBottom: NSLayoutConstraint!
    @IBOutlet var viewInTable: UIView!
    
    var villageEnterprise : VillageEnterpriseVO = VillageEnterpriseVO()
    
    
    override func viewDidLoad() {
        print("전달받은 아이디값")
        print(villageEnterpriseId)
        
        detailTable.delegate = self
        detailTable.dataSource = self
        detailTable.separatorStyle = .none
        photo_collection.delegate = self
        photo_collection.dataSource = self
        detailTable.estimatedRowHeight = 200.0
        detailTable.rowHeight = UITableViewAutomaticDimension
        detailTable.tableFooterView = UIView.init(frame: .zero)
        mapView.delegate = self
        mapView.clear()
        detail.isScrollEnabled = true
       // self.view.addSubview(mapView)
        let model = SearchModel(self)
        model.searchSpecificVe(villageEnterpriseId: self.villageEnterpriseId)
        startLoading()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}

extension VEDetailVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0{
            return 180
        }
        else{
            return UITableViewAutomaticDimension
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
        let news_cell = detailTable.dequeueReusableCell(withIdentifier: "VEDetailNewsCell") as! VEDetailNewsCell
            news_cell.stack.isHidden = true
            news_cell.state.text = "업데이트중입니다"
            
         return news_cell
        }
        
        else if indexPath.row == 1{
            let info_cell = detailTable.dequeueReusableCell(withIdentifier: "VEDetailInfoCell") as! VEDetailInfoCell
            
            info_cell.address.text = gsno(villageEnterprise.address)
            info_cell.phone.text = gsno(villageEnterprise.phone)
            info_cell.url.text = gsno(villageEnterprise.url)
            info_cell.url.isScrollEnabled = false
            info_cell.mapView.addSubview(self.mapView)
            

            return info_cell
        }
        else if indexPath.row == 2{
            
            let coupon_cell = detailTable.dequeueReusableCell(withIdentifier: "VEDetailCouponCell") as! VEDetailCouponCell
            coupon_cell.coupon_img.imageFromUrl(gsno(villageEnterprise.coupon), defaultImgPath: "coffee")
            coupon_cell.coupon_view.layer.borderWidth = 1.5
            coupon_cell.coupon_view.layer.cornerRadius = 5.0
            coupon_cell.coupon_view.layer.borderColor = UIColor(hex:"F2AE22").cgColor
            return coupon_cell
        }
        else{
        return UITableViewCell()
        }
    }
    
    @objc func clicked_news(_ sender : UIButton){
        
//
//        let index = sender.tag
//        if let url = URL(string:gsno(homeVO?.villageinformation[index].inforUrl)){
//            UIApplication.shared.openURL(url)
//        }
//
//
        
    }
    
}
extension VEDetailVC : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("콜렉션카운트")
        print(collection_photo_list.count)
        return collection_photo_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var imageVO = collection_photo_list[indexPath.item]
        let cell = photo_collection.dequeueReusableCell(withReuseIdentifier: "photoCollectionCell", for: indexPath) as! photoCollectionCell

        cell.image.imageFromUrl(imageVO, defaultImgPath: "2")
        cell.image.layer.cornerRadius = 5
        cell.image.clipsToBounds = true
        return cell
    }
}

extension VEDetailVC : NetworkCallback {
    
    func networkResult(resultData: Any, apiCode: String) {
      
        stopLoading()
        
        if apiCode == "3-1"{
            stopLoading()
            villageEnterprise = resultData as! VillageEnterpriseVO
            photo.imageFromUrl(gsno(villageEnterprise.photo), defaultImgPath: "1")
            detail.text = gsno(villageEnterprise.detail)
            print("마을기업 위치이이")
            print(villageEnterprise.lat)
            print(villageEnterprise.lng)
            
            ve_name.text = gsno(villageEnterprise.name)
    

            let ve_location = CLLocation.init(latitude: gdno(villageEnterprise.lat),longitude: gdno(villageEnterprise.lng))
            let camera = GMSCameraPosition.camera(withLatitude: ve_location.coordinate.latitude, longitude: ve_location.coordinate.longitude, zoom: 16.0)
            mapView.animate(to: camera)
            locationManager.stopUpdatingLocation()
            
            let maker = GMSMarker()
            maker.position = CLLocationCoordinate2DMake(ve_location.coordinate.latitude, ve_location.coordinate.longitude)
            maker.title = gsno(villageEnterprise.name)
            maker.icon = #imageLiteral(resourceName: "location")
            maker.snippet = "Korea"
             maker.map = mapView

      
            
            for image in villageEnterprise.images{
                if let image_ = image.image{
                collection_photo_list.append(image_)
                }
            }
            if collection_photo_list.count == 0{
                photo_collection.removeFromSuperview()
                viewInTable.frame.size.height -= photo_collection.frame.size.height - 100.0
          //      textToBottom.constant = 0
                self.view.layoutIfNeeded()
            }
            else{
            photo_collection.reloadData()
            }
        
            detailTable.reloadData()
            detail.frame.size.height = detail.contentSize.height
            detailTable.estimatedRowHeight = 200.0
            detailTable.rowHeight = UITableViewAutomaticDimension
            
        }//3-1
    }//result
}

extension VEDetailVC :  CLLocationManagerDelegate, GMSMapViewDelegate{
    
    
}
