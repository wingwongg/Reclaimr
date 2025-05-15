//
//  SettingsPageView.swift
//  Reclaimr
//
//  Created by ben on 9/5/25.
//

import FamilyControls
import ManagedSettings
import SwiftUI

struct SettingsPageView : View {
    @State private var isPresented = false
    
    @EnvironmentObject var model: DataModel
    
    var body: some View {
        NavigationStack {
            List {
                Section() {
                    NavigationLink("Account Settings") {
                        // swipe left transition to account settings
                    }
                    
                    NavigationLink("Edit Goals") {
                        GoalsSettingView()
                    }
                    
                    Button("Restricted Apps") { isPresented = true }
                       .familyActivityPicker(isPresented: $isPresented,
                                             selection: $model.selectionToDiscourage)
                       .foregroundColor(.black)
                    
                }
                
                Section() {
                    
                    NavigationLink("Appearance") {
                        // swipe left transition to Appearance settings
                    }
                    
                    NavigationLink("Privacy and Security") {
                        // swipe left transition to Privacy and data settings
                    }
                    
                    NavigationLink("Parents and Kids Mode") {
                        // swipe left transition to Parents and Kids Mode
                    }
                }
            }
        }.navigationTitle("Settings")
    }
}

struct SettingsPageView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPageView()
            .environmentObject(DataModel())
            .environmentObject(ManagedSettingsStore())
    }
}
