//
//  ReclaimrApp.swift
//  Reclaimr
//
//  Created by ben on 9/5/25.
//

import SwiftUI
import FamilyControls
import ManagedSettings

@main
struct ReclaimrApp : App {
    
    @StateObject var model = DataModel.shared
    @StateObject var store = ManagedSettingsStore()
    
    @State private var viewModel = ViewModel()
    
    let center = AuthorizationCenter.shared
    
    var body: some Scene {
        WindowGroup {
            HomePageView()
        .onAppear {
            Task {
                viewModel.startMonitoring()
                    do {
                        try await center.requestAuthorization(for: .individual)
                    } catch {
                        // handle error
                    }
                }
            }
        .environmentObject(model)
        .environmentObject(store)
        }
    }
}
