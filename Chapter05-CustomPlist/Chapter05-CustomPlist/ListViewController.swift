//
//  ListViewController.swift
//  Chapter05-CustomPlist
//
//  Created by 박시현 on 2020/01/03.
//  Copyright © 2020 박시현. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var name: UILabel!
    @IBOutlet var gender: UISegmentedControl!
    @IBOutlet var married: UISwitch!
    @IBOutlet var account: UITextField!
    
    var accountlist = Set<String>()
    
    var defaultPList: NSDictionary!
    
    @IBAction func edit(_ sender: Any) {
        if (self.account.text?.isEmpty)! {
            return
        }
        let alert = UIAlertController(title: nil, message: "이름을 입력하세요", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: {
            $0.text = self.name.text
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { (_) in
            let value = alert.textFields?[0].text
            
            let customPlist = "\(self.account.text!).plist"
            
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let path = paths[0] as NSString
            let plist = path.strings(byAppendingPaths: [customPlist]).first!
            let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary(dictionary: self.defaultPList)
            
            data.setValue(value, forKey: "name")
            data.write(toFile: plist, atomically: true)
            
            self.name.text = value
        })
        self.present(alert, animated: false, completion: nil)
    }
    @IBAction func changeGender(_ sender: UISegmentedControl) {
        let value = sender.selectedSegmentIndex
        
        let customPlist = "\(self.account.text!).plist"
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = paths[0] as NSString
        let plist = path.strings(byAppendingPaths: [customPlist]).first!
        let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary(dictionary: self.defaultPList)
        
        data.setValue(value, forKey: "gender")
        data.write(toFile: plist, atomically: true)
    }
    @IBAction func changeMarried(_ sender: UISwitch) {
        let value = sender.isOn
        
        let customPlist = "\(self.account.text!).plist"
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = paths[0] as NSString
        let plist = path.strings(byAppendingPaths: [customPlist]).first!
        let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary(dictionary: self.defaultPList)
        
        data.setValue(value, forKey: "married")
        data.write(toFile: plist, atomically: true)
        
        print("\(plist)")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let defaultPListPath = Bundle.main.path(forResource: "UserInfo", ofType: "plist") {
            self.defaultPList = NSDictionary(contentsOfFile: defaultPListPath)
        }
        
        let plist = UserDefaults.standard
        
        self.name.text = plist.string(forKey: "name")
        self.married.isOn = plist.bool(forKey: "married")
        self.gender.selectedSegmentIndex = plist.integer(forKey: "gender")
        
        let picker = UIPickerView()
        
        picker.delegate = self
        self.account.inputView = picker // 인풋 뷰에 picker를 사용, 기본은 키보드
        
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 35)
        toolbar.barTintColor = UIColor.lightGray
        
        self.account.inputAccessoryView = toolbar
        
        let done = UIBarButtonItem()
        done.title = "Done"
        done.target = self
        done.action = #selector(pickerDone)
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let new = UIBarButtonItem()
        new.title = "New"
        new.target = self
        new.action = #selector(newAccount(_:))
        
        toolbar.setItems([new, flexSpace, done], animated: true)
        
        let accountlist = plist.array(forKey: "accountlist") as? [String] ?? [String]()
        self.accountlist = Set(accountlist)
        
        if let account = plist.string(forKey: "selectedAccount") {
            self.account.text = account
        }
        
        let customPlist = "\(self.account.text!).plist"
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = paths[0] as NSString
        let clist = path.strings(byAppendingPaths: [customPlist]).first!
        let data = NSMutableDictionary(contentsOfFile: clist)
        
        self.name.text = data?["name"] as? String
        self.gender.selectedSegmentIndex = data?["gender"] as? Int ?? 0
        self.married.isOn = data?["married"] as? Bool ?? false
        
        if (self.account.text?.isEmpty)! {
            self.account.placeholder = "등록된 계정이 없습니다."
            self.gender.isEnabled = false
            self.married.isEnabled = false
        }
        
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newAccount(_:)))
        self.navigationItem.rightBarButtonItems = [addBtn]
    }
    
    @objc
    func pickerDone(_ sender: Any) {
        self.view.endEditing(true)
        
        if let _account = self.account.text {
            let customPlist = "\(_account).plist"
            
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let path = paths[0] as NSString
            let clist = path.strings(byAppendingPaths: [customPlist]).first!
            let data = NSMutableDictionary(contentsOfFile: clist)
            
            self.name.text = data?["name"] as? String
            self.gender.selectedSegmentIndex = data?["gender"] as? Int ?? 0
            self.married.isOn = data?["married"] as? Bool ?? false
        }
    }

    @objc
    func newAccount(_ sender: Any) {
        self.view.endEditing(true)
        let alert = UIAlertController(title: "새 계정을 입력하세요", message: nil, preferredStyle: .alert)
        
        alert.addTextField() {
            $0.placeholder = "ex) abc@gmail.com"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            if let account = alert.textFields?[0].text {
                self.accountlist.insert(account) // HERE
                self.account.text = account
                
                self.name.text = ""
                self.gender.selectedSegmentIndex = 0
                self.married.isOn = false
                
                let plist = UserDefaults.standard
                
                let tempList = Array(self.accountlist)
                
                plist.set(tempList, forKey: "accountlist")
                plist.set(account, forKey: "selectedAccount")
                plist.synchronize()
                
                self.gender.isEnabled = true
                self.married.isEnabled = true
            }
        }))
        self.present(alert, animated: false, completion: nil)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return super.numberOfSections(in: tableView)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 && !(self.account.text?.isEmpty)!{
            self.edit(tableView)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.accountlist.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let tempList = Array(accountlist) //Here
        return tempList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let tempList = Array(accountlist) //Here
        let account = tempList[row]
        self.account.text = account
        
        let plist = UserDefaults.standard
        plist.set(account, forKey: "selectedAccount")
        plist.synchronize()
    }
}
