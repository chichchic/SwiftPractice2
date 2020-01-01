//
//  ViewController.swift
//  Chapter03-TabBar
//
//  Created by 박시현 on 2020/01/01.
//  Copyright © 2020 박시현. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 30))
        
        title.text = "첫 번째 탭"
        title.textColor = UIColor.red
        title.textAlignment = .center
        title.font = UIFont.boldSystemFont(ofSize: 14)
        title.sizeToFit()
        title.center.x = self.view.frame.width / 2
        
        self.view.addSubview(title)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let tabBar = self.tabBarController?.tabBar  else {
            return
        }
        
       // tabBar.isHidden = (tabBar.isHidden == true) ? false : true
        UIView.animate(withDuration: 0.15){
            tabBar.alpha = ( tabBar.alpha == 0 ? 1 : 0 )
        }
        
    }

}

