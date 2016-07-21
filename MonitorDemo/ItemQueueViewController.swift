//
//  ItemQueueViewController.swift
//  MonitorDemo
//
//  Created by Sam Wu on 7/21/16.
//  Copyright © 2016 BothPoints. All rights reserved.
//

import UIKit

final class ItemQueueViewController: UITableViewController {

    private var dataSource: ItemQueueDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDataSource()
    }
    
    private func setUpDataSource() {
        dataSource = ItemQueueDataSource(tableView: self.tableView)
        dataSource?.setUpDataSource()
        tableView.dataSource = dataSource
        tableView.reloadData()
    }


}
