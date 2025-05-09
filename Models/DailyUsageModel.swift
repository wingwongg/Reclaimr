//
//  DailyUsageModel.swift
//  Reclaimr
//
//  Created by ben on 9/5/25.
//

import SwiftUI

struct DailyUsageModel {
    var date: Date
    var screenTime: Int
    var productiveTime: Int
    var tasksCompleted: [ProductiveTask]
}
