//
//  LoadingView.swift
//  Seouri
//
//  Created by 하태경 on 2017. 10. 2..
//  Copyright © 2017년 SOPT. All rights reserved.
//


import UIKit

class LoadingView: UIActivityIndicatorView {
    
    var containerView = UIView()
    
    open func startLoading(_ view: UIView) {
        containerView.frame = view.frame
        containerView.center = view.center
        containerView.backgroundColor = UIColor(white: 0, alpha: 0.8)
        
        self.center = view.center
        containerView.addSubview(self)
        view.addSubview(containerView)
        
        self.startAnimating()
    }
    
    open func stopLoading() {
        self.stopAnimating()
        containerView.removeFromSuperview()
    }
    
    
    open class var shared: LoadingView {
        struct Static {
            static let instance: LoadingView = LoadingView()
        }
        return Static.instance
    }
}
