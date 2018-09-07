//
//  PopAnimation.swift
//  AppleMusice
//
//  Created by Benq on 2017/8/3.
//  Copyright © 2017年 qipeishang. All rights reserved.
//

import UIKit

class PopAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let from = transitionContext.viewController(forKey: .from)
        let to = transitionContext.viewController(forKey: .to)
        let containerView = transitionContext.containerView

        let offScreenFrame = CGRect(x: 0, y: containerView.bounds.height, width: containerView.bounds.width, height: containerView.bounds.height)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .curveEaseInOut, animations: {
            
            containerView.backgroundColor = UIColor(white: 0, alpha: 0)
            
//            to?.view.alpha = 1
//            to?.view.transform = .identity
//            to?.view.layer.mask = nil
            
//            from?.view.mask = nil
            from?.view.frame = offScreenFrame
        }) { (finished) in
            transitionContext.completeTransition(finished)
        }
    }
}
