//
//  MonitorService.swift
//  MonitorDemo
//
//  Created by Sam Wu on 7/21/16.
//  Copyright © 2016 BothPoints. All rights reserved.
//

import Foundation

protocol MonitorServiceDelegate: class {
    
    func monitorServiceDelegate(monitorService: MonitorService, didReceiveUpdate: MonitorUpdate)
}

final class MonitorService {
    var timer: NSTimer!
    
    weak var delegate: MonitorServiceDelegate?
    
    init()
    {
        timer = NSTimer.scheduledTimerWithTimeInterval(2,
                                                       target: self,
                                                       selector: #selector(generateUpdate),
                                                       userInfo: nil,
                                                       repeats: true)
    }
}

// MARK: - Helpers
extension MonitorService {
    @objc private func generateUpdate()
    {
        let update = MonitorUpdate.randomUpdate
        
        delegate?.monitorServiceDelegate(self, didReceiveUpdate: update)
    }
}