//
//  SecondViewController.swift
//  AppleMusice
//
//  Created by Benq on 2017/8/3.
//  Copyright © 2017年 qipeishang. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    deinit {
        print("deinit \(self)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.blue
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissSelf))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.yellow
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        
        let label = UILabel()
        label.text = "let tap = UITapGestureRecognizer(target: self, action: #selector(dismissSelf))"
        label.numberOfLines = 0
        scrollView.addSubview(label)
        label.frame = CGRect(x: 0, y: 0, width: 300, height: 500)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height * 2)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.lastContentOffset = scrollView.contentOffset.y
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height * 2)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews")
    }
    
    let scrollView = UIScrollView(frame: CGRect.zero)
    var lastContentOffset: CGFloat = 0
    
    @objc func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SecondViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y > self.lastContentOffset {
//            scrollView.bounces = true
            print("scrollViewDidScroll true")
            print(scrollView.contentOffset.y)
//            if !self.isBeingDismissed {
//                view.transform = CGAffineTransform(translationX: 0, y: 0)
//            }
        } else {
            print("scrollViewDidScroll false")
            //TODO 判断加速度是否直接 Dismiss
            guard self.isBeingDismissed == false else {
                return
            }
            if scrollView.isDecelerating {
            } else {
//                scrollView.bounces = false
            }
            
            let value = CGAffineTransform(translationX: 0, y: -scrollView.contentOffset.y)
            view.transform = value
            
            let value2 = CGAffineTransform(translationX: 0, y: scrollView.contentOffset.y)
            _ = scrollView.subviews.map({ $0.transform = value2 })

            

            //TODO 100 数值根据 view Height 确定
            if -scrollView.contentOffset.y > 200 {
                self.dismissSelf()
            }
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("scrollViewDidEndScrollingAnimation")
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scrollViewWillBeginDragging")
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print("scrollViewWillEndDragging   \(velocity)   \(targetContentOffset.pointee.y)")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollViewDidEndDragging \(decelerate)")
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewWillBeginDecelerating")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
    }
}

