//
//  CSLogButton.swift
//  MyMemory
//
//  Created by 박시현 on 2020/01/02.
//  Copyright © 2020 박시현. All rights reserved.
//

import UIKit

public enum CSLogType: Int {
    case basic
    case title
    case tag
}

public class CSLogButton: UIButton {

    public var logType: CSLogType = .basic
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setBackgroundImage(UIImage(named: "button-bg"), for: .normal)
        self.tintColor = UIColor.white
        
        self.addTarget(self, action: #selector(loggin(_:)), for: .touchUpInside)
    }
    
    @objc
    func loggin(_ sender: UIButton) {
        switch self.logType {
        case .basic:
            NSLog("버튼이 클릭되었습니다.")
        case .title:
            let btnTitle = sender.titleLabel?.text ?? "타이틀이 없는"
            NSLog("\(btnTitle)버튼이 클릭되었습니다.")
        case .tag:
            NSLog("\(sender.tag)버튼이 클릭되었습니다.")
        }
    }

}
