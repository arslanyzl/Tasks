//
//  TaskListView 2.swift
//  TrackDailyTasks
//
//  Created by Arslan Yazlyyev on 3/12/25.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        if appState.tasks.isEmpty {
            EmptyStateView()
        } else {
            List {
                ForEach(prioritizedTasks) { task in
                    TaskRowView(task: task)
                        .swipeActions {
                            Button(role: .destructive) {
                                appState.deleteTask(task)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            
                            Button {
                                toggleTaskCompletion(task)
                            } label: {
                                Label(
                                    task.isCompleted ? "Mark Incomplete" : "Mark Complete",
                                    systemImage: task.isCompleted ? "xmark.circle" : "checkmark.circle"
                                )
                            }
                            .tint(task.isCompleted ? .orange : .green)
                        }
                }
            }
        }
    }
    
    private var prioritizedTasks: [Task] {
        let sortOrder: [TaskPriority] = [.high, .medium, .low]
        return appState.tasks.sorted { task1, task2 in
            if task1.isCompleted == task2.isCompleted {
                let priority1 = sortOrder.firstIndex(of: task1.priority) ?? 0
                let priority2 = sortOrder.firstIndex(of: task2.priority) ?? 0
                return priority1 < priority2
            }
            return !task1.isCompleted && task2.isCompleted
        }
    }
    
    private func toggleTaskCompletion(_ task: Task) {
        var updatedTask = task
        updatedTask.isCompleted.toggle()
        appState.updateTask(updatedTask)
    }
}

// MARK: - Preview Provider
struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
            .environmentObject(createMockAppState())
    }
    
    // Helper function to create mock AppState with specific date and theme
    static func createMockAppState() -> AppState {
        let mockRepo = MockTaskRepository(withSampleData: true)
        let mockTaskUseCase = MockTaskUseCase(repository: mockRepo)
        
        // Create a date navigation use case that returns our specific date
        let mockDateUseCase = MockDateNavigationUseCase()
        
        // Create a theme use case with our settings
        let mockThemeUseCase = MockThemeUseCase()
        
        // Create and return the AppState
        return AppState(
            taskUseCase: mockTaskUseCase,
            dateNavigationUseCase: mockDateUseCase,
            themeUseCase: mockThemeUseCase
        )
    }
}
