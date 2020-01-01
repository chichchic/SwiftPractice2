//
//  ControlViewController.swift
//  Chapter03-Alert
//
//  Created by 박시현 on 2020/01/01.
//  Copyright © 2020 박시현. All rights reserved.
//

import UIKit

class ControlViewController: UIViewController {

    private let slider = UISlider()
    
    //get만 가능하도록 설계
    var sliderValue: Float {
        return self.slider.value
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.slider.minimumValue = 0
        self.slider.maximumValue = 100
        
        self.slider.frame = CGRect(x: 0, y: 0, width: 170, height: 30)
        self.view.addSubview(self.slider)
        
        self.preferredContentSize = CGSize(width: self.slider.frame.width, height: self.slider.frame.height+10)
    }
    

}
