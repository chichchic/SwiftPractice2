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
        navigationItem.title = "설정"
        
        let lblEmail = UILabel(frame: CGRect(x: 30, y: 100, width: 100, height: 30))
        lblEmail.text = "이메일"
        lblEmail.font = UIFont.systemFont(ofSize: 14)
        
        let lblUpdate = UILabel(frame: CGRect(x: lblEmail.frame.origin.x, y: lblEmail.frame.origin.y+50, width: 100, height: 30))
        lblUpdate.text = "자동갱신"
        lblUpdate.font = UIFont.systemFont(ofSize: 14)
        
        let lblInterval = UILabel(frame: CGRect(x: lblEmail.frame.origin.x, y: lblEmail.frame.origin.y+100, width: 100, height: 30))
        lblInterval.text = "갱신주기"
        lblInterval.font = UIFont.systemFont(ofSize: 14)
        
        txtUpdate = UILabel(frame: CGRect(x: lblEmail.frame.origin.x+220, y: 150, width: 100, height: 30))
        txtUpdate.font = UIFont.systemFont(ofSize: 12)
        txtUpdate.textColor = UIColor.red
        txtUpdate.text = "갱신함"
        
        txtInterval = UILabel(frame: CGRect(x: txtUpdate.frame.origin.x, y: txtUpdate.frame.origin.y+50, width: 100, height: 30))
        txtInterval.font = UIFont.systemFont(ofSize: 12)
        txtInterval.textColor = UIColor.red
        txtInterval.text = "0분마다"
        
        view.addSubview(lblEmail)
        view.addSubview(lblUpdate)
        view.addSubview(lblInterval)
        view.addSubview(txtUpdate)
        view.addSubview(txtInterval)
        
        paramEmail = UITextField(frame: CGRect(x: lblEmail.frame.origin.x+90, y: 100, width: 220, height: 30))
        paramEmail.font = UIFont.systemFont(ofSize: 13)
        paramEmail.borderStyle = UITextField.BorderStyle.roundedRect
        paramEmail.autocapitalizationType = .none
        view.addSubview(paramEmail)
        
        paramUpdate = UISwitch(frame: CGRect(x: paramEmail.frame.origin.x, y: paramEmail.frame.origin.y+50, width: 50, height: 30))
        paramUpdate.setOn(true, animated: true)
        view.addSubview(paramUpdate)
        paramUpdate.addTarget(self, action: #selector(presentUpdateValue(_:)), for: .valueChanged)
        
        paramInterval = UIStepper(frame: CGRect(x: paramEmail.frame.origin.x, y: paramEmail.frame.origin.y+100, width: 50, height: 30))
        paramInterval.minimumValue = 0
        paramInterval.maximumValue = 100
        paramInterval.stepValue = 1
        paramInterval.value = 0
        view.addSubview(paramInterval)
        paramInterval.addTarget(self, action: #selector(presentIntervalValue), for: .valueChanged)
        
        let submitBtn = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(submit(_:)))
        navigationItem.rightBarButtonItem = submitBtn
    }

    @objc
    func presentUpdateValue(_ sender: UISwitch) {
        txtUpdate.text = (sender.isOn == true ? "갱신함" : "갱신하지 않음")
    }
    
    @objc
    func presentIntervalValue(_ sender: UIStepper) {
        txtInterval.text = "\(Int(sender.value))분마다"
    }
    
    @objc
    func submit(_ sender: UIBarButtonItem) {
        let rvc = ReadViewController()
        rvc.pEmail = paramEmail.text
        rvc.pUpdate = paramUpdate.isOn
        rvc.pInterval = paramInterval.value
        
        navigationController?.pushViewController(rvc, animated: true)
    }

}

