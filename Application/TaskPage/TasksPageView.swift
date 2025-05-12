//
//  TasksPageView.swift
//  Reclaimr
//
//  Created by ben on 9/5/25.
//

import SwiftUI

struct TasksPageView : View {
    @State private var showingAddTaskSheet = false
    @State private var showingEditTaskSheet = false
    @State private var showingDeleteTaskAlert = false
    @EnvironmentObject var taskList: TaskListModel
    
    var body: some View {
        NavigationStack {
            
            VStack() {
                
                List {
                    ForEach(taskList.tasks) { task in
                        HStack(alignment: .center) {
                            VStack(alignment: .leading) {
                                Text(task.name).font(.headline)
                                HStack() {
                                    Text("Time: \(task.rewardMinutes) min")
                                    Text("Points: 100")
                                }
                                .font(.caption2)
                            }
                            Spacer()
                            Button() {
                                showingEditTaskSheet = true
                            } label: {
                                Image(systemName: "square.and.pencil")
                                    .padding(.bottom, 2)
                                // pop up to add task
                            }
                            .sheet(isPresented: $showingEditTaskSheet) {
                                EditTaskPopupView(isPresented: $showingEditTaskSheet, currentTask: task) { name, time in
                                    // Handle your task logic here
                                    taskList.editTask(task, name, time)
                                }
                            }
    
                            Button() {
                                
                            } label: {
                                Image(systemName: "gearshape")
                                // pop up to confirm deletion of tasks
                            }
                            .alert("Add Task", isPresented: $showingDeleteTaskAlert) {
                                Button("Confirm", role: .cancel) {
                                    // action
                                }
                                Button("Cancel", role: .destructive) {}
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Time Earners")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button() {
                    // pop up to add task
                    showingAddTaskSheet = true
                } label: {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $showingAddTaskSheet) {
                    AddTaskPopupView(isPresented: $showingAddTaskSheet) { name, time in
                        // Handle your task logic here
                        taskList.addTask(TaskModel(name: name, rewardMinutes: time))
                    }
                }
            }
        }
    }
}

#Preview {
    TasksPageView()
}
