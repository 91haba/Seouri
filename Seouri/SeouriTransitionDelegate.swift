//
//  SeouriTransitionDelegate.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 21.
//  Copyright © 2017년 Seouri. All rights reserved.
//

import UIKit


class SeouriTransitionDelegate: NSObject,UIViewControllerTransitioningDelegate{
   
    
    var height: CGFloat = 470
    var width : CGFloat = 375
    
    override init() {
        super.init()
    }
    
    init(height: CGFloat) {
        super.init()
        self.height = height
    }
    init(height: CGFloat, width : CGFloat) {
        super.init()
        self.height = height
        self.width = width
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController!, source: UIViewController) -> UIPresentationController? {
        let presentationController = SeouriPresentationController(presentedViewController:presented, presenting:presenting, height: height)
      
        return presentationController
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = SeouriAnimatedTransitioning()
        animationController.isPresentation = true
        return animationController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = SeouriAnimatedTransitioning()
        animationController.isPresentation = false
        return animationController
    }


}
