//
//  TasksPageView.swift
//  Reclaimr
//
//  Created by ben on 9/5/25.
//

import SwiftUI

struct TasksPageView : View {
    var body: some View {
        NavigationStack {
            
            VStack() {
                
//                HStack() {
//                    Spacer()
//                    Text("Let's do some tasks")
//                    Spacer()
//                    Image(systemName: "plus")
//                }
//                .padding(.horizontal)
                
                List {
                    HStack() {
                        VStack() {
                            Text("Go out for a run").font(.headline)
                            HStack() {
                                Text("Time: 30m")
                                Text("Points: 100")
                            }
                            .font(.caption2)
                        }
                        Spacer()
                        Image(systemName: "square.and.pencil")
                        Image(systemName: "gearshape")
                    }
                    
                    HStack() {
                        VStack() {
                            Text("Read a book").font(.headline)
                            HStack() {
                                Text("Time: 15m")
                                Text("Points: 50")
                            }
                            .font(.caption2)
                        }
                        Spacer()
                        Image(systemName: "square.and.pencil")
                        Image(systemName: "gearshape")
                    }
                    
                    HStack() {
                        VStack() {
                            Text("Do a workout").font(.headline)
                            HStack() {
                                Text("Time: 45m")
                                Text("Points: 150")
                            }
                            .font(.caption2)
                        }
                        Spacer()
                        Image(systemName: "square.and.pencil")
                        Image(systemName: "gearshape")
                    }
                }
            }
        }
        .navigationTitle("Let's do some tasks")
    }
}

#Preview {
    TasksPageView()
}
