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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
            return cell
        } else {
            return rCell
        }
    }

    override func viewWillAppear(_ animated: Bool) {
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
