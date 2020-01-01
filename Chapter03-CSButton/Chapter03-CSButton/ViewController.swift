//
//  ViewController.swift
//  Chapter03-CSButton
//
//  Created by 박시현 on 2020/01/01.
//  Copyright © 2020 박시현. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = CGRect(x: 30, y: 50, width: 150, height: 30)
        let csBtn = CSButton(frame: frame)
        self.view.addSubview(csBtn)
        
        let recBtn = CSButton(type: .rect)
        recBtn.frame = CGRect(x: 30, y: 200, width: 150, height: 30)
        self.view.addSubview(recBtn)
        
        let ciBtn = CSButton(type: .circle)
        ciBtn.frame = CGRect(x: 200, y: 200, width: 150, height: 30)
        self.view.addSubview(ciBtn)
        
//        recBtn.style = .circle
    }


}

