//
//  ReclaimrAppViewModel.swift
//  Reclaimr
//
//  Created by ben on 9/5/25.
//

import SwiftUI
import DeviceActivity

extension ReclaimrApp {
    @Observable
    class ViewModel {
        func getScheduleDeviceActivity() -> DeviceActivitySchedule {
                return DeviceActivitySchedule(
                    intervalStart: DateComponents(hour: 0, minute: 0, second: 0),
                    intervalEnd: DateComponents(hour: 23, minute: 59, second: 59),
                    repeats: true
                )
        }
        
        func startMonitoring() {
            let timeLimitMinutes = DataModel.shared.dailyScreenTimeLimitHours * 60
            let selection = DataModel.shared.selectionToDiscourage
            let limitReachedEvent = DeviceActivityEvent(
                applications: selection.applicationTokens,
                categories: selection.categoryTokens,
                webDomains: selection.webDomainTokens,
                threshold: DateComponents(minute: 1))
            
            let center = DeviceActivityCenter()
            let activity = DeviceActivityName("MyApp.ScreenTime")
            let eventName = DeviceActivityEvent.Name("MyApp.limitReached")
            let schedule = getScheduleDeviceActivity()
            
            do {
                try center.startMonitoring(
                    activity,
                    during: schedule,
                    events: [eventName: limitReachedEvent])
            } catch { }
        }
    }
}
