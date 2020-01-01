//
//  ListViewController.swift
//  Chapter03-Alert
//
//  Created by 박시현 on 2020/01/01.
//  Copyright © 2020 박시현. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

    var delegate: MapAlertViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.preferredContentSize.height = 220
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = "\(indexPath.row)"
        cell.textLabel!.font = UIFont.systemFont(ofSize: 13)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectRowAt(indexPath: indexPath)
    }
}
