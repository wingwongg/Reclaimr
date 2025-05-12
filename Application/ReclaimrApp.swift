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
    
    @StateObject var screenTimeModel = DataModel.shared
    @StateObject var store = ManagedSettingsStore()
    @StateObject var taskModel = TaskListModel.shared
    
    @State private var viewModel = ViewModel()
    
    let center = AuthorizationCenter.shared
    
    var body: some Scene {
        WindowGroup {
            HomePageView()
        .onAppear {
            viewModel.getSelection() // load the selection whenever the homescreen appears?
            Task {
                viewModel.startMonitoring()
                    do {
                        try await center.requestAuthorization(for: .individual)
                    } catch {
                        // handle error
                    }
                }
            }
        .environmentObject(screenTimeModel)
        .environmentObject(store)
        .environmentObject(taskModel)
        }
    }
}
