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
//    private let encoder = NSSecureCoding()
//    private let decoder = NSKeyedUnarchiver()
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
    
    var selectionToDiscourage: FamilyActivitySelection {
        set(selection) {
//            print("saving the selections...")
                let defaults = UserDefaults.standard
                defaults.set(try? encoder.encode(selection), forKey: "selectionToDiscourage")
         }
            
         get {
//             print("getting selections...")
                let defaults = UserDefaults.standard
                guard let data = defaults.data(forKey: "selectionToDiscourage"),
                        let decoded = try? decoder.decode(FamilyActivitySelection.self, from: data) else {
                 return FamilyActivitySelection()
             }
             return decoded
         }
    }
    
    func setSelection(selection: FamilyActivitySelection) {
            let defaults = UserDefaults.standard
            defaults.set(try? encoder.encode(selection), forKey: "selectionToDiscourage")
     }
        
     func getSelection() -> FamilyActivitySelection {
            let defaults = UserDefaults.standard
            guard let data = defaults.data(forKey: "selectionToDiscourage"),
                    let decoded = try? decoder.decode(FamilyActivitySelection.self, from: data) else {
             return FamilyActivitySelection()
         }
         return decoded
     }
    
    func updateSelection(_ selection: FamilyActivitySelection) {
            selectionToDiscourage = selection
            setSelection(selection: selection)
    }
    
    init() {
        print("created")
        selectionToDiscourage = FamilyActivitySelection()
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
