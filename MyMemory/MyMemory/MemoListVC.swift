//
//  MemoListVC.swift
//  MyMemory
//
//  Created by 박시현 on 2019/12/28.
//  Copyright © 2019 박시현. All rights reserved.
//

import UIKit

class MemoListVC: UITableViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let revealVC = self.revealViewController() {
            let btn = UIBarButtonItem()
            btn.image = UIImage(named: "sidemenu.png")
            btn.target = revealVC
            btn.action = #selector(revealVC.revealToggle(_:))
            
            self.navigationItem.leftBarButtonItem = btn
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let count = self.appDelegate.memolist.count
        return count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.appDelegate.memolist[indexPath.row]
        let cellId = row.image == nil ? "memoCell" : "memoCellWithImage"
        let rCell = MemoCell()
      //  let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! MemoCell
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? MemoCell {
            cell.subject?.text = row.title
            cell.contents?.text = row.contents
            cell.img?.image = row.image
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            cell.regdate?.text = formatter.string(from: row.regdate!)
            
            return cell
        } else {
            rCell.subject?.text = row.title
            rCell.contents?.text = row.contents
            rCell.img?.image = row.image
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            rCell.regdate?.text = formatter.string(from: row.regdate!)
            return rCell
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        let ud = UserDefaults.standard
        if ud.bool(forKey: UserInfoKey.tutorial) == false {
            let vc = self.instanceTutorialVC(name: "MasterVC")
            self.present(vc!, animated: false)
            
            return
        }
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "memoCellWithImageSegue" || segue.identifier == "memoCellSegue"){
            let vc = segue.destination as? MemoReadVC
            let selectedIndex = tableView.indexPathForSelectedRow!.row
            vc?.param = self.appDelegate.memolist[selectedIndex]
        }
    }
    
}
