//
//  ItemQueueDataSource.swift
//  MonitorDemo
//
//  Created by Sam Wu on 7/21/16.
//  Copyright © 2016 BothPoints. All rights reserved.
//

import UIKit

final class ItemQueueDataSource: NSObject {
    
    private let monitorService: MonitorService
    
    private var queue: [MonitorUpdate] = []
    
    private let tableView: UITableView
    
    init(tableView: UITableView, monitorService: MonitorService = MonitorService()) {
        self.monitorService = monitorService
        self.tableView = tableView
        
    }
    
    func setUpDataSource() {
        setUpTableView()
        registerCells()
        monitorService.delegate = self
    }
    
    private func setUpTableView() {
        tableView.estimatedRowHeight = 100
    }
    
    private func registerCells() {
        tableView.registerReusableCell(ItemCell.self)
    }
        

}

extension ItemQueueDataSource: MonitorServiceDelegate {
    
    func monitorServiceDelegate(monitorService: MonitorService, didReceiveUpdate update: MonitorUpdate) {
        
        switch update.status {
        case .AddedToQueue:
            queue.append(update)
        case .RemovedFromQueue:
            guard let index = queue.indexOf({ $0.itemNumber == update.itemNumber }) else {
                return
            }
            queue.removeAtIndex(index)
        }
        tableView.reloadData()
    }
}

extension ItemQueueDataSource: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return queue.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let itemUpdate = queue[indexPath.row]
        
        let itemCell = tableView.dequeueReusableCell(indexPath: indexPath) as ItemCell
                
        itemCell.viewModel = ItemCell.ViewModel(itemImage: nil, itemNumber: itemUpdate.itemNumber, kioskNumber: itemUpdate.kioskNumber, startTime: itemUpdate.time, itemStatus: ItemCell.ItemStatus.Waiting)
        
        return itemCell
    }
    
}