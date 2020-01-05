//
//  TutorialContentsVC.swift
//  MyMemory
//
//  Created by 박시현 on 2020/01/04.
//  Copyright © 2020 박시현. All rights reserved.
//

import UIKit

class TutorialContentsVC: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bgImageView: UIImageView!
    
    var pageIndex: Int!
    var titleText: String!
    var imageFile: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = self.titleText
        self.titleLabel.sizeToFit()
        
        self.bgImageView.image = UIImage(named: self.imageFile)
        self.view.bringSubviewToFront(self.titleLabel)
    }
    

}
