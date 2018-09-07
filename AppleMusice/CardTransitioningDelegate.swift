//
//  CardTransitioningDelegate.swift
//  AppleMusice
//
//  Created by Benq on 2017/8/29.
//  Copyright © 2017年 qipeishang. All rights reserved.
//

import UIKit

public final class CardTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    var height: CGFloat?
    
    fileprivate let pushAnimate = PushAnimation()
    fileprivate let popAnimate = PopAnimation()
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        pushAnimate.finalHeight = height
        return pushAnimate
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return popAnimate
    }

}
