//
//  MemoFormVC.swift
//  MyMemory
//
//  Created by 박시현 on 2019/12/28.
//  Copyright © 2019 박시현. All rights reserved.
//

import UIKit

class MemoFormVC: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    var subject: String!
    var flagImageSave = false
    @IBOutlet var contents: UITextView!
    @IBOutlet var preview: UIImageView!
    
    @IBAction func save(_ sender: Any) {
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        let data = MemoData()
        
        data.title = self.subject
        data.contents = self.contents.text
        data.image = self.preview.image
        data.regdate = Date()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memolist.append(data)
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pick(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "이미지를 가져올 곳을 선택해주세요", preferredStyle: .actionSheet)
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        alert.addAction(UIAlertAction(title: "카메라", style: .default){ (_) in
                picker.sourceType = .camera
                self.present(picker, animated: false)
        })
        alert.addAction(UIAlertAction(title: "저장앨범", style: .default){ (_) in
            self.present(picker, animated: false)
        })
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.contents.delegate = self
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage{
                    self.preview.image = editedImage
                    picker.dismiss(animated: false)
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        let contents = textView.text as NSString
        let length = ((contents.length > 15) ? 15 : contents.length)
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        self.navigationItem.title = subject
    }
}
