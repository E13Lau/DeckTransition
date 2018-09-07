//
//  PushAnimation.swift
//  AppleMusice
//
//  Created by Benq on 2017/8/3.
//  Copyright © 2017年 qipeishang. All rights reserved.
//

import UIKit

class PushAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    var fromScale: CGFloat = 1
    var finalHeight: CGFloat?
    
    weak var toViewController: UIViewController?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let tap = UITapGestureRecognizer(target: self, action: #selector(pop))
        containerView.addGestureRecognizer(tap)
        
//        let from = transitionContext.viewController(forKey: .from)
        guard let from = transitionContext.viewController(forKey: .from) else {
            transitionContext.completeTransition(false)
            return
        }
        guard let to = transitionContext.viewController(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }
        
        toViewController = to
        
        containerView.backgroundColor = UIColor(white: 0, alpha: 0)
//        let scale: CGFloat = 1 - (80 / from.view.frame.height)
        let scale = self.fromScale
        containerView.addSubview(to.view)
        var finalFrame = transitionContext.finalFrame(for: to)
        if let height = finalHeight {
            finalFrame = CGRect(x: finalFrame.minX, y: finalFrame.height - height, width: finalFrame.width, height: height)
        }
        let startFrame = CGRect(x: 0, y: containerView.bounds.height, width: containerView.bounds.width, height: finalHeight ?? containerView.bounds.height)
        to.view.frame = startFrame
        
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0.1, options: [.curveEaseOut], animations: {
            
            containerView.backgroundColor = UIColor(white: 0, alpha: 0.3)
            
            from.view.transform = CGAffineTransform(scaleX: scale, y: scale)
//            from.view.corner(1, 1, 0, 0)
            
            to.view.corner(1, 1, 0, 0)
            to.view.frame = finalFrame
        }) { (_) in
            transitionContext.completeTransition(true)
        }
        
//        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0.1, usingSpringWithDamping: 0.93, initialSpringVelocity: 0.3, options: .curveEaseOut, animations: {
//            from.view.transform = CGAffineTransform(scaleX: scale, y: scale)
//            from.view.corner(1, 1, 0, 0)
//            to.view.corner(1, 1, 0, 0)
//            to.view.frame = CGRect(x: 0, y: 40, width: finalFrame.width, height: finalFrame.height)
//        }) { (_) in
//            transitionContext.completeTransition(true)
//        }
    }
    
    @objc func pop() {
        toViewController?.dismiss(animated: true, completion: nil)
    }
    
    func corner(_ view: UIView) {
        
    }
}

fileprivate extension UIView {
    //加 View 圆角
    func corner(_ topLeft: CGFloat,_ topRight: CGFloat,_ bottomLeft: CGFloat, _ bottomRight: CGFloat) {
        let rect = self.bounds
        var optionSet: UIRectCorner = []
        if topLeft > 0 {
            optionSet.insert(.topLeft)
        }
        if topRight > 0 {
            optionSet.insert(.topRight)
        }
        if bottomLeft > 0 {
            optionSet.insert(.bottomLeft)
        }
        if bottomRight > 0 {
            optionSet.insert(.bottomRight)
        }
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: optionSet, cornerRadii: CGSize(width: 10, height: 10))
        let sharpLayer = CAShapeLayer()
        sharpLayer.path = path.cgPath
        self.layer.mask = sharpLayer
    }
}
