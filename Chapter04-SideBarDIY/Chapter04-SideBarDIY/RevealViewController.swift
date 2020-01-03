//
//  RevealViewController.swift
//  Chapter04-SideBarDIY
//
//  Created by 박시현 on 2020/01/02.
//  Copyright © 2020 박시현. All rights reserved.
//

import UIKit

class RevealViewController: UIViewController {

    var contentVC: UIViewController?
    var sideVC: UIViewController?
    
    var isSideVarShowing = false
    
    let SLIDE_TIME = 0.3
    let SIDEBAR_WIDTH: CGFloat = 260
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_front") as? UINavigationController {
            let frontVC = vc.viewControllers[0] as? FrontViewController
            frontVC?.delegate = self
            self.contentVC = vc
            self.addChild(vc)
            self.view.addSubview(vc.view)
            vc.didMove(toParent: self)
        }
    }
    
    func getSideView() {
        if self.sideVC == nil {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_rear") {
                self.sideVC = vc
                self.addChild(vc)
                self.view.addSubview(vc.view)
                vc.didMove(toParent: self)
                self.view.bringSubviewToFront((self.contentVC?.view)!)
            }
        }
    }
    
    //그림자 안되는 이유를 모르겠어...
    func setShadowEffect(shadow: Bool, offset: CGFloat){
        if (shadow == true) {
//            self.contentVC?.view.layer.cornerRadius = 10
            self.contentVC?.view.layer.shadowOpacity = 0.8
            self.contentVC?.view.layer.shadowColor = UIColor.black.cgColor
            self.contentVC?.view.layer.shadowOffset = CGSize(width: -100, height: 1)
        } else {
            self.contentVC?.view.layer.cornerRadius = 0.0
            self.contentVC?.view.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
    }
    
    func openSideBar(_ complete: ( ()-> Void)?) {
        self.getSideView()
        self.setShadowEffect(shadow: true, offset: -2)
        
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState]) // 실행 속도 옵션
        // linear ease-in ease-out ease-inease-out 등이 있음
        
        UIView.animate(withDuration: self.SLIDE_TIME, delay: 0, options: options, animations: {
            self.contentVC?.view.frame =
                CGRect(x: self.SIDEBAR_WIDTH, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
        }, completion: {
            if $0 == true {
                self.isSideVarShowing = true
                complete?()
            }
        })
    }
    
    func closeSideBar(_ complete: (() -> Void)?) {
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        
        UIView.animate(withDuration: self.SLIDE_TIME, delay: 0, options: options, animations: {
            self.contentVC?.view.frame =
                CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
        }, completion: {
            if $0 == true {
                self.sideVC?.view.removeFromSuperview()
                self.sideVC = nil
                self.isSideVarShowing = false
                self.setShadowEffect(shadow: false, offset: 0)
                complete?()
            }
        })
    }

}
