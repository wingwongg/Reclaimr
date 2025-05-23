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
        
        func getSelection() {
            SharedDataModel.shared.loadSelection()
        }
        
        func startMonitoring() {
            let timeLimitMinutes = SharedDataModel.shared.dailyScreenTimeLimit * 60
            let selection = SharedDataModel.shared.selectionToDiscourage
            let limitReachedEvent = DeviceActivityEvent(
                applications: selection.applicationTokens,
                categories: selection.categoryTokens,
                webDomains: selection.webDomainTokens,
                threshold: DateComponents(minute: timeLimitMinutes)) // timeLimitMinutes
            
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
        
        func completeSetup() {
            let defaults = UserDefaults(suiteName: "group.com.nebitrams.Reclaimr")
            defaults?.set(true, forKey: "hasCompletedSetup")
        }
    }
}
