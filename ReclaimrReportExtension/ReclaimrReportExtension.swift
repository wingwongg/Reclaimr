//
//  ReclaimrReportExtension.swift
//  ReclaimrReportExtension
//
//  Created by ben on 9/5/25.
//

import DeviceActivity
import SwiftUI

@main
struct ReclaimrReportExtension: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView(totalActivity: totalActivity)
        }
        // Add more reports here...
    }
}
