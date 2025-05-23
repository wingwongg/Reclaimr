//
//  SharedDataModel.swift
//  Reclaimr
//
//  Created by ben on 15/5/25.
//

//import DeviceActivity
//import Foundation
//import FamilyControls
//import ManagedSettings
//import SwiftUI
//
//private let _SharedDataModel = SharedDataModel()
//
//class SharedDataModel : ObservableObject {
//    static let defaultsGroup: UserDefaults? = UserDefaults(suiteName: "group.com.nebitrams.Reclaimr")
//    private let selectionsKey = "SelectionToDiscourage"
//    private let encoder = JSONEncoder()
//    private let decoder = JSONDecoder()
//    let store = ManagedSettingsStore()
//    
//    @GroupAppStorage("dailyScreenTimeLimit", suiteName: "group.com.nebitrams.Reclaimr") var dailyScreenTimeLimit: Int = 0
//    
//    @GroupAppStorage("dailyProductiveGoal", suiteName: "group.com.nebitrams.Reclaimr") var dailyProductiveGoal: Int = 0
//    
//    @GroupAppStorage("dailyProductiveHours", suiteName: "group.com.nebitrams.Reclaimr") var dailyProductiveHours: Int = 0
//    
//    @Published var selectionToDiscourage: FamilyActivitySelection = FamilyActivitySelection()
//    
//    init() {
//        
//    }
//    
//    class var shared: SharedDataModel {
//        return _SharedDataModel
//    }
//    
//    func saveSelection() {
//        if let data = try? encoder.encode(selectionToDiscourage) {
//            SharedDataModel.defaultsGroup!.set(data, forKey: selectionsKey)
//        }
//    }
//    
//    func loadSelection() {
//        guard let data = SharedDataModel.defaultsGroup!.data(forKey: selectionsKey),
//              let selection = try? decoder.decode(FamilyActivitySelection.self, from: data) else {
//            return
//        }
//        selectionToDiscourage = selection
//    }
//    
//}
//    
////    func setShieldRestrictions() {
////        // this blocks selected apps
////        
////        let applications = SharedDataModel.shared.selectionToDiscourage
////        
////        store.shield.applications = applications.applicationTokens.isEmpty ? nil : applications.applicationTokens
////        store.shield.applicationCategories = applications.categoryTokens.isEmpty
////        ? nil
////        : ShieldSettings.ActivityCategoryPolicy.specific(applications.categoryTokens)
////    }

import Foundation
import SwiftUI
import FamilyControls
import ManagedSettings
import DeviceActivity

final class SharedDataModel: ObservableObject {
    static let shared = SharedDataModel()
    static let screenTimeLimitDidChange = Notification.Name("screenTimeLimitDidChange")
    
    private static let appGroupID = "group.com.nebitrams.Reclaimr"
    private static let defaults = UserDefaults(suiteName: appGroupID)

    private enum Keys {
        static let selectionToDiscourage = "SelectionToDiscourage"
        static let dailyScreenTimeLimit = "dailyScreenTimeLimit"
        static let dailyProductiveGoal = "dailyProductiveGoal"
        static let dailyProductiveHours = "dailyProductiveHours"
    }
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    let store = ManagedSettingsStore()
    
    @Published var selectionToDiscourage: FamilyActivitySelection = FamilyActivitySelection()
    
    private init() {
        
    }
    
    var dailyScreenTimeLimit: Int {
        get { Self.defaults?.integer(forKey: Keys.dailyScreenTimeLimit) ?? 0 }
        set {
            Self.defaults?.set(newValue, forKey: Keys.dailyScreenTimeLimit)
            Self.defaults?.synchronize()
            NotificationCenter.default.post(name: SharedDataModel.screenTimeLimitDidChange, object: nil)
        }
    }

    var dailyProductiveGoal: Int {
        get { Self.defaults?.integer(forKey: Keys.dailyProductiveGoal) ?? 0 }
        set { Self.defaults?.set(newValue, forKey: Keys.dailyProductiveGoal)
            Self.defaults?.synchronize() }
    }
    
    var dailyProductiveHours: Int {
        get { Self.defaults?.integer(forKey: Keys.dailyProductiveHours) ?? 0 }
        set { Self.defaults?.set(newValue, forKey: Keys.dailyProductiveHours)
            Self.defaults?.synchronize() }
    }
    
    func saveSelection() {
        guard let data = try? encoder.encode(selectionToDiscourage),
              let defaults = Self.defaults else {
            print("Failed to encode or access shared defaults")
            return
        }
        defaults.set(data, forKey: Keys.selectionToDiscourage)
        Self.defaults?.synchronize()
    }
    
    func loadSelection() {
        guard let defaults = Self.defaults,
              let data = defaults.data(forKey: Keys.selectionToDiscourage),
              let selection = try? decoder.decode(FamilyActivitySelection.self, from: data) else {
            print("No saved selection or failed to decode")
            return
        }
        selectionToDiscourage = selection
    }
}
