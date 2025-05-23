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
    
    @StateObject var screenTimeModel = SharedDataModel.shared
    @StateObject var store = ManagedSettingsStore()
    @StateObject var taskListModel = TaskListModel.shared
    
    @State private var hasCompletedSetup = UserDefaults(suiteName: "group.com.nebitrams.Reclaimr")?.bool(forKey: "hasCompletedSetup")
    @State private var viewModel = ViewModel()
    
    let center = AuthorizationCenter.shared
    
    var body: some Scene {
        WindowGroup {
            if hasCompletedSetup! {
                HomePageView()
                    .onAppear {
                        viewModel.getSelection() // load the selection whenever the homescreen appears
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
                    .environmentObject(taskListModel)
                    .defaultAppStorage(UserDefaults(suiteName: "group.com.nebitrams.Reclaimr")!)
            }
            else {
                OnboardingView(onFinish: {
                    viewModel.completeSetup()
                    hasCompletedSetup = true
                })
            }
        }
    }
}
