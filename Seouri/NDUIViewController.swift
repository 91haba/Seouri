//
//  UIViewControllerExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import SJSegmentedScrollView

extension SJSegmentedViewController {
    
 
    override func setNavigationBarItem() {
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
     //   self.navigationItem.rightBarButtonItems = [searchBtn,messageBtn]
        self.navigationController?.navigationBar.backgroundColor = UIColor(hex: "5A5A5A")
        self.navigationController?.navigationBar.tintColor = UIColor(hex: "37B0A6")
       // self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
       // self.addRightBarButtonWithImage(UIImage(named: "ic_notifications_black_24dp")!)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
        self.slideMenuController()?.addRightGestures()
    }
    
    override func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
    }
    
}//extension

extension UIViewController {

    func setNavigationBarItem() {
        self.navigationController?.navigationBar.backgroundColor = UIColor(hex: "5A5A5A")
        self.navigationController?.navigationBar.tintColor = UIColor(hex: "37B0A6")
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
        // self.addRightBarButtonWithImage(UIImage(named: "ic_notifications_black_24dp")!)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
        self.slideMenuController()?.addRightGestures()
    }

    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
    }



}
