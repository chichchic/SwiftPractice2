//
//  ReadViewController.swift
//  Chapter02-InputForm
//
//  Created by 박시현 on 2019/12/31.
//  Copyright © 2019 박시현. All rights reserved.
//

import UIKit
class ReadViewController: UIViewController {
    var pEmail: String?
    var pUpdate: Bool?
    var pInterval: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let email = UILabel(frame: CGRect(x: 50, y: 100, width: 300, height: 30))
        let update = UILabel(frame: CGRect(x: 50, y: 150, width: 300, height: 30))
        let Interval = UILabel(frame: CGRect(x: 50, y: 200, width: 300, height: 30))
        
        email.text = self.pEmail!
        update.text = (self.pUpdate!) ? "업데이트 함" : "업데이트 안함"
        Interval.text = "\(Int(self.pInterval!))"
        
        self.view.addSubview(email)
        self.view.addSubview(update)
        self.view.addSubview(Interval)
    }
}
