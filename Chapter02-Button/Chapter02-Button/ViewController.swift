//
//  ViewController.swift
//  Chapter02-Button
//
//  Created by 박시현 on 2019/12/31.
//  Copyright © 2019 박시현. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let btn = UIButton(type: UIButton.ButtonType.system)
        btn.frame = CGRect(x: 50, y: 50, width: 150, height: 30)
        btn.setTitle("테스트 버튼", for: UIControl.State.normal)
        btn.center = CGPoint(x: self.view.frame.size.width/2, y: 100)
        
        self.view.addSubview(btn)
        
        btn.addTarget(self, action: #selector(btnOnClick(_:)), for: .touchUpInside)
    }

    @objc
    func btnOnClick(_ sender: Any){
        if let btn = sender as? UIButton {
            
            btn.setTitle("클릭되었습니다.", for: UIControl.State.normal)
        }
    }
}

