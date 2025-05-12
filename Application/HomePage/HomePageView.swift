//
//  HomePageView.swift
//  Reclaimr
//
//  Created by ben on 9/5/25.
//

import SwiftUI
import DeviceActivity
import FamilyControls

struct HomePageView : View {

    @State private var viewModel = ViewModel()
    @State private var context: DeviceActivityReport.Context = .init(rawValue: "Total Activity")
    @State private var filter = DeviceActivityFilter(
       segment: .daily(
           during: Calendar.current.dateInterval(
               of: .day, for: .now
           )!
       ),
       devices: .init([.iPhone, .iPad]),
       applications: DataModel.shared.selectionToDiscourage.applicationTokens,
       categories: DataModel.shared.selectionToDiscourage.categoryTokens,
       webDomains: DataModel.shared.selectionToDiscourage.webDomainTokens
   )
    
    var body: some View {
        NavigationStack() {
            VStack() {
                HStack() {
                    // maybe add a menu? to access daily quest and productivity log
                    
                    Spacer()
                    NavigationLink {
                        SettingsPageView()
                    } label: {
                        Image(systemName: "gearshape")
                            .padding(20)
                    }
                }
                
                Text("Reclaimr").font(.largeTitle)
                
                Text("You have 1h30m of screen time remaining")
                    .padding(.vertical, 50)
                    .padding(.horizontal, 20)
                
                HStack() {
                    // customize activity report
                    DeviceActivityReport(context, filter: filter)
                        .frame(width: 200.0, height: 200.0)
                    
                    // Circle productive hours
                    CircularProgressRing(progress: 0.4, size: 150, color: .green)
                        .padding(.trailing, 30.0)
                        .frame(width: 200.0, height: 200.0)
                }
                
                NavigationLink {
                    TasksPageView()
                } label: {
                    Text("Do Tasks")
                        .foregroundColor(.white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .background(Rectangle().foregroundColor(.green))
                        .cornerRadius(15)
                        .padding(.vertical, 30)
                }
                
                // productivity log preview: list of tasks done today
                
                Spacer()
            }
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
            .environmentObject(DataModel())
    }
}
