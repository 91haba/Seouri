
//
//  SeouriPresentationController.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 21..
//  Copyright © 2017년 Seouri. All rights reserved.
//

import UIKit


class SeouriPresentationController : UIPresentationController, UIAdaptivePresentationControllerDelegate{

    var height: CGFloat = 470
    var width : CGFloat = 375
    var chromeView: UIView = UIView()
    
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController!, height: CGFloat) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        chromeView.backgroundColor = UIColor(white:0.0, alpha:0.4)
        chromeView.alpha = 0.0
        self.height = height
        
                let tap = UITapGestureRecognizer(target: self, action: #selector(chromeViewTapped))
                chromeView.addGestureRecognizer(tap)
    }
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController!, height: CGFloat, width : CGFloat) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        chromeView.backgroundColor = UIColor(white:0.0, alpha:0.4)
        chromeView.alpha = 0.0
        self.height = height
        self.width = width
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(chromeViewTapped))
        chromeView.addGestureRecognizer(tap)
    }
    
    @objc func chromeViewTapped(_ gesture: UIGestureRecognizer) {
        if (gesture.state == UIGestureRecognizerState.ended) {
            presentingViewController.dismiss(animated: true, completion: nil)
        }
    }
    
    func setTapDismiss() {
        chromeView.removeGestureRecognizer((chromeView.gestureRecognizers?[0])!)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var presentedViewFrame = CGRect.zero
        let parentView = presentingViewController.view!
        let containerBounds = containerView?.bounds
        presentedViewFrame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: (containerBounds?.size)!)
        presentedViewFrame.origin.x = parentView.center.x - (parentView.frame.width - 40)/2.0
        presentedViewFrame.origin.y = parentView.center.y - height/2
      //  presentedViewFrame.origin.x = parentView.center.x
      //  presentedViewFrame.origin.y = parentView.center.y
        
        return presentedViewFrame
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width - 40, height: height)
    }
    
    override func presentationTransitionWillBegin() {
        chromeView.frame = (self.containerView?.bounds)!
        chromeView.alpha = 0.0
        containerView?.insertSubview(chromeView, at:0)
        let coordinator = presentedViewController.transitionCoordinator
        if (coordinator != nil) {
            coordinator!.animate(alongsideTransition: {
                (context:UIViewControllerTransitionCoordinatorContext!) -> Void in
                self.chromeView.alpha = 1.0
            }, completion:nil)
        } else {
            chromeView.alpha = 1.0
        }
    }
    
    override func dismissalTransitionWillBegin() {
        let coordinator = presentedViewController.transitionCoordinator
        if (coordinator != nil) {
            coordinator!.animate(alongsideTransition: {
                (context:UIViewControllerTransitionCoordinatorContext!) -> Void in
                self.chromeView.alpha = 0.0
            }, completion:nil)
        } else {
            chromeView.alpha = 0.0
        }
    }
    
    override func containerViewWillLayoutSubviews() {
        chromeView.frame = (containerView?.bounds)!
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override var shouldPresentInFullscreen: Bool {
        return true
    }
    
    override var adaptivePresentationStyle: UIModalPresentationStyle {
        return .none
    }
    
    

}
