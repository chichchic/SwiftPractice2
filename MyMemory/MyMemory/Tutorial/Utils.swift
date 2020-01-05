//
//  Utils.swift
//  MyMemory
//
//  Created by 박시현 on 2020/01/04.
//  Copyright © 2020 박시현. All rights reserved.
//

extension UIViewController {
    var tutorialSB: UIStoryboard {
        return UIStoryboard(name: "Tutorial", bundle: Bundle.main)
    }
    func instanceTutorialVC(name: String) -> UIViewController? {
        return self.tutorialSB.instantiateViewController(withIdentifier: name)
    }
}
