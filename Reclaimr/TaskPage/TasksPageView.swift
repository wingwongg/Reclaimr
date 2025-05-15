//
//  TasksPageView.swift
//  Reclaimr
//
//  Created by ben on 9/5/25.
//

import SwiftUI

struct TasksPageView : View {
    @State private var showingAddTaskSheet = false
    @State private var selectedTaskForEditing: TaskModel?
    @State private var showingDeleteConfirmation = false
    @State private var selectedTaskForDeletion: TaskModel?

    @EnvironmentObject var taskList: TaskListModel
    
    var body: some View {
        ZStack {
            NavigationStack {
                List {
                    ForEach(taskList.tasks) { task in
                        Button {
                            // Log the task
                            
                        } label: {
                            TaskRowView(currentTask: task)
                        }
                        .foregroundColor(.black)
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                // Delay the deletion so the swipe resets first
                                selectedTaskForDeletion = task
                                showingDeleteConfirmation = true
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                selectedTaskForEditing = task
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.blue)
                        }
                    }
                }
            }
            .navigationTitle("Time Earners")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button() {
                        showingAddTaskSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            // Edit Task
            .sheet(item: $selectedTaskForEditing) { task in
                EditTaskPopupView(
                    isPresented: Binding(
                        get: { selectedTaskForEditing != nil },
                        set: { if !$0 { selectedTaskForEditing = nil } }
                    ),
                    currentTask: task) { name, time in
                        taskList.editTask(selectedTaskForEditing!, name, time)
                    }
            }
            // Add Task
            .sheet(isPresented: $showingAddTaskSheet) {
                AddTaskPopupView(isPresented: $showingAddTaskSheet) { name, time in
                    // add task
                    taskList.addTask(TaskModel(name: name, rewardMinutes: time))
                }
            }
            // Delete Task
            if showingDeleteConfirmation {
                BottomDeleteConfirmationView(
                    onDelete: {
                        if let task = selectedTaskForDeletion {
                            taskList.deleteTask(task)
                        }
                        selectedTaskForDeletion = nil
                        showingDeleteConfirmation = false
                    },
                    onCancel: {
                        selectedTaskForDeletion = nil
                        showingDeleteConfirmation = false
                    }
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .zIndex(1)
            }
        }
    }
}

struct TasksPageView_Previews: PreviewProvider {
    static var previews: some View {
        TasksPageView()
            .environmentObject(TaskListModel())
    }
}
