//
//  DataModel.swift
//  Reclaimr
//
//  Created by ben on 9/5/25.
//

import DeviceActivity
import Foundation
import FamilyControls
import ManagedSettings
import SwiftUI

private let _DataModel = DataModel()

class DataModel : ObservableObject {
    let store = ManagedSettingsStore()
    
    private let userDefaultsKey = "SelectionToDiscourage"
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    var dailyScreenTimeLimitHours: Int {
        get {
            let hours = UserDefaults.standard.integer(forKey: "dailyScreenTimeHours")
            return hours == 0 ? 1 : hours
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "dailyScreenTimeHours")
        }
    }
    
    var dailyProductiveHours: Int {
        get {
            let hours = UserDefaults.standard.integer(forKey: "dailyProductiveHours")
            return hours == 0 ? 1 : hours
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "dailyProductiveHours")
        }
    }
    
    @Published var selectionToDiscourage: FamilyActivitySelection = FamilyActivitySelection()
    
    func saveSelection() {
        if let data = try? encoder.encode(selectionToDiscourage) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
    }
        
     func loadSelection() -> FamilyActivitySelection {
         guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
                    let selection = try? decoder.decode(FamilyActivitySelection.self, from: data) else {
             return FamilyActivitySelection()
         }
         return selection
     }
    
    init() {
//        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
//                   let selection = try? decoder.decode(FamilyActivitySelection.self, from: data) else {
//            selectionToDiscourage = FamilyActivitySelection()
//        }
//        selectionToDiscourage = selection
    }
    
    class var shared: DataModel {
        return _DataModel
    }
    
    func setShieldRestrictions() {
        // this blocks selected apps
        
        let applications = DataModel.shared.selectionToDiscourage
        
        store.shield.applications = applications.applicationTokens.isEmpty ? nil : applications.applicationTokens
        store.shield.applicationCategories = applications.categoryTokens.isEmpty
        ? nil
        : ShieldSettings.ActivityCategoryPolicy.specific(applications.categoryTokens)
    }
}
