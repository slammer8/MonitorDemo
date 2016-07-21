//
//  MonitorUpdate.swift
//  MonitorDemo
//
//  Created by Sam Wu on 7/21/16.
//  Copyright © 2016 BothPoints. All rights reserved.
//

import Foundation

enum MonitorUpdateStatus: Int {
    case AddedToQueue = 0
    case RemovedFromQueue = 1
}

struct MonitorUpdate {
    let itemNumber: Int
    let kioskNumber: Int
    let time: NSDate
    let status: MonitorUpdateStatus
}

// MARK: - Helpers
extension MonitorUpdate {
    static var randomUpdate: MonitorUpdate {
        let itemNumber = Int(arc4random_uniform(10))
        let kioskNumber = Int(arc4random_uniform(3))
        let rawStatus = Int(arc4random_uniform(2))
        let status = MonitorUpdateStatus(rawValue: rawStatus)!
        return MonitorUpdate(itemNumber: itemNumber, kioskNumber: kioskNumber, time: NSDate(), status: status)
    }
}