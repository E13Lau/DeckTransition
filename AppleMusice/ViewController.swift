//
//  ViewController.swift
//  AppleMusice
//
//  Created by Benq on 2017/8/3.
//  Copyright © 2017年 qipeishang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        let tap = UITapGestureRecognizer(target: self, action: #selector(pushSecond))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        
        self.setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height * 2)
    }
    
    let scrollView = UIScrollView(frame: CGRect.zero)
    
    func setup() {
        self.navigationController?.delegate = self
    }
    
    func setupViews() {
        let button = UIButton(type: .system)
        button.setTitle("Add", for: [])
        button.addTarget(self, action: #selector(add), for: .touchUpInside)
        let show = UIButton(type: .system)
        show.setTitle("show", for: [])
        show.addTarget(self, action: #selector(showPrint), for: .touchUpInside)
        button.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        show.frame = CGRect(x: 50, y: 150, width: 100, height: 100)
        
        view.addSubview(button)
        view.addSubview(show)
    }
    
    @objc func add() {
        let cache = NSCache<NSString, NSArray>()
        let time = "\(Date().timeIntervalSince1970)"
        let array = NSArray(array: [time, time, time])
        cache.setObject(array, forKey: NSString(string: "label"))
    }
    
    @objc func showPrint() {
        let cache = NSCache<NSString, NSArray>()
        if let label = cache.object(forKey: NSString(string: "label")) {
            label.forEach({ (item) in
                print(item)
            })
        }
    }
    
    @objc func pushSecond() {
        
        dele.height = 500
        
        
        let second = SecondViewController(nibName: nil, bundle: nil)
        second.modalPresentationStyle = .custom
        second.transitioningDelegate = dele
        self.present(second, animated: true, completion: nil)
    }
    
    let dele = CardTransitioningDelegate()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return PushAnimation()
        case .pop:
            return PopAnimation()
        default:
            return nil
        }
    }
}









