//
//  ViewController.swift
//  Chapter02-InputForm
//
//  Created by 박시현 on 2019/12/31.
//  Copyright © 2019 박시현. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var paramEmail: UITextField!
    var paramUpdate: UISwitch!
    var paramInterval: UIStepper!
    var txtUpdate: UILabel!
    var txtInterval: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "설정"
        
        let lblEmail = UILabel(frame: CGRect(x: 30, y: 100, width: 100, height: 30))
        lblEmail.text = "이메일"
        lblEmail.font = UIFont.systemFont(ofSize: 14)
        
        let lblUpdate = UILabel(frame: CGRect(x: 30, y: 150, width: 100, height: 30))
        lblUpdate.text = "자동갱신"
        lblUpdate.font = UIFont.systemFont(ofSize: 14)
        
        let lblInterval = UILabel(frame: CGRect(x: 30, y: 200, width: 100, height: 30))
        lblInterval.text = "갱신주기"
        lblInterval.font = UIFont.systemFont(ofSize: 14)
        
        self.txtUpdate = UILabel(frame: CGRect(x: 250, y: 150, width: 100, height: 30))
        self.txtUpdate.font = UIFont.systemFont(ofSize: 12)
        self.txtUpdate.textColor = UIColor.red
        self.txtUpdate.text = "갱신함"
        
        self.txtInterval = UILabel(frame: CGRect(x: 250, y: 200, width: 100, height: 30))
        self.txtInterval.font = UIFont.systemFont(ofSize: 12)
        self.txtInterval.textColor = UIColor.red
        self.txtInterval.text = "0분마다"
        
        self.view.addSubview(lblEmail)
        self.view.addSubview(lblUpdate)
        self.view.addSubview(lblInterval)
        self.view.addSubview(txtUpdate)
        self.view.addSubview(txtInterval)
        
        self.paramEmail = UITextField(frame: CGRect(x: 120, y: 100, width: 220, height: 30))
        self.paramEmail.font = UIFont.systemFont(ofSize: 13)
        self.paramEmail.borderStyle = UITextField.BorderStyle.roundedRect
        self.paramEmail.autocapitalizationType = .none
        self.view.addSubview(paramEmail)
        
        self.paramUpdate = UISwitch(frame: CGRect(x: 120, y: 150, width: 50, height: 30))
        self.paramUpdate.setOn(true, animated: true)
        self.view.addSubview(paramUpdate)
        self.paramUpdate.addTarget(self, action: #selector(presentUpdateValue(_:)), for: .valueChanged)
        
        self.paramInterval = UIStepper(frame: CGRect(x: 120, y: 200, width: 50, height: 30))
        self.paramInterval.minimumValue = 0
        self.paramInterval.maximumValue = 100
        self.paramInterval.stepValue = 1
        self.paramInterval.value = 0
        self.view.addSubview(paramInterval)
        self.paramInterval.addTarget(self, action: #selector(presentIntervalValue), for: .valueChanged)
        
        let submitBtn = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(submit(_:)))
        self.navigationItem.rightBarButtonItem = submitBtn
    }

    @objc
    func presentUpdateValue(_ sender: UISwitch) {
        self.txtUpdate.text = (sender.isOn == true ? "갱신함" : "갱신하지 않음")
    }
    
    @objc
    func presentIntervalValue(_ sender: UIStepper) {
        self.txtInterval.text = "\(Int(sender.value))분마다"
    }
    
    @objc
    func submit(_ sender: UIBarButtonItem) {
        let rvc = ReadViewController()
        rvc.pEmail = self.paramEmail.text
        rvc.pUpdate = self.paramUpdate.isOn
        rvc.pInterval = self.paramInterval.value
        
        self.navigationController?.pushViewController(rvc, animated: true)
    }

}

