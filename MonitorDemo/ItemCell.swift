//
//  ItemCell.swift
//  MonitorDemo
//
//  Created by Sam Wu on 7/21/16.
//  Copyright © 2016 BothPoints. All rights reserved.
//

import UIKit

final class ItemCell: UITableViewCell {
    
    enum ItemStatus: String {
        case Waiting = "Waiting"
        case InTransit = "In Transit"
    }
    
    struct ViewModel {
        
        var itemImage: UIImage?
        let itemNumber: String
        let kioskNumber: Int
        let startTime: NSDate
        let itemStatus: ItemStatus
        let numberFormatter: NSNumberFormatter
        
    }
    
    var viewModel: ViewModel? {
        didSet {
            updateCell()
        }
    }
    
    @IBOutlet private weak var itemImageView: UIImageView!
    @IBOutlet private weak var itemNumberLabel: UILabel!
    @IBOutlet private weak var kioskNumberLabel: UILabel!
    @IBOutlet private weak var queueTimerLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var actionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell()
    }

    private func setUpCell() {
        itemImageView.layer.cornerRadius = itemImageView.bounds.width / 2
        itemImageView.layer.borderColor = UIColor.grayColor().CGColor
        itemImageView.layer.borderWidth = 2
        
        // set up fonts
        // set up button
    }
    
    private func updateCell() {
        guard let viewModel = viewModel else {
            return
        }
        
        itemImageView.image = viewModel.itemImage
        
        itemNumberLabel.text = "#\(viewModel.itemNumber)"
        kioskNumberLabel.text = String(viewModel.kioskNumber)

        statusLabel.text = viewModel.itemStatus.rawValue
        createTimer()

    }
    
    private func createTimer() {
        NSTimer.scheduledTimerWithTimeInterval(1,
                                               target: self,
                                               selector: #selector(updateTimerLabel),
                                               userInfo: nil,
                                               repeats: true)

    }
    
    @objc private func updateTimerLabel() {
        
        let numberFormatter = NSNumberFormatter()
        numberFormatter.minimumIntegerDigits = 2
        numberFormatter.maximumIntegerDigits = 2
        
        guard let timerString = createTimerStringFromDate(viewModel?.startTime, numberFormatter: numberFormatter) else { return }
        
        queueTimerLabel.text = timerString
    }
    
    private func createTimerStringFromDate(date: NSDate?, numberFormatter: NSNumberFormatter = NSNumberFormatter()) -> String? {
        
        guard let date = date else { return nil }
        
        let timeInterval = NSDate().timeIntervalSinceDate(date)
        
        let minutes = floor(timeInterval / 60)
        let seconds = timeInterval % 60
        
        guard let minuteString = numberFormatter.stringFromNumber(minutes), secondsString = numberFormatter.stringFromNumber(seconds) else { return nil }
        
        return String(":\(minuteString):\(secondsString)")
    }

    
    @IBAction private func actionButtonPressed(sender: AnyObject) {
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        backgroundColor = selected ? .redColor() : .whiteColor()
    }
    
}

extension ItemCell: Reusable {
    static var nib: UINib? {
        return UINib(nibName: String(ItemCell.self), bundle: nil)
    }
}
