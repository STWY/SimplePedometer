//
//  TodayViewController.swift
//  Pedometer
//
//  Created by STWY on 16/5/22.
//  Copyright © 2016年 STWY. All rights reserved.
//

import Foundation
import NotificationCenter
import CoreMotion

class TodayViewController: UIViewController, NCWidgetProviding {
    
    // StepCountLabel
    @IBOutlet var stepCountLabel: UILabel!
    
    // Pedometer
    var stepCount: Int
    var pedometer: CMPedometer
    
    // MARK: - Initializers
    init() {
        stepCount = 0
        pedometer = CMPedometer()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        stepCount = 0
        pedometer = CMPedometer()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateStepCountLabel()
        updatePedometer()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Widget
    func updatePedometer () {
        // Ensure device has motion coprocessor
        if CMPedometer.isStepCountingAvailable() {
            
            // Get data from midnight to now
            pedometer.queryPedometerDataFromDate(NSDate.midnight, toDate: NSDate(), withHandler: {
                data, error in
                
                if data != nil {
                    // Store data
                    self.stepCount = data!.numberOfSteps.integerValue
                    self.updateStepCountLabel()
                }
                
                // Update as user moves
                self.pedometer.startPedometerUpdatesFromDate(NSDate(), withHandler: {
                    data, error in
                    
                    if data != nil {
                        // Add to existing counts
                        self.stepCount += data!.numberOfSteps.integerValue
                        self.updateStepCountLabel()
                    }
                })
            })
        }
    }
    
    func updateStepCountLabel () {
        dispatch_async(dispatch_get_main_queue(), {
            self.stepCountLabel.text = "\(self.stepCount)"
        });
    }
}
