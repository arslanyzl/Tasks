//
//  TaskRowView.swift
//  TrackDailyTasks
//
//  Created by Arslan Yazlyyev on 3/12/25.
//

import SwiftUI

struct TaskRowView: View {
    let task: Task
    @EnvironmentObject private var appState: AppState
    @State private var showingEditTask = false
    
    var body: some View {
        Button(action: {
            showingEditTask = true
        }) {
            HStack {
                Circle()
                    .fill(priorityColor)
                    .frame(width: 12, height: 12)
                
                VStack(alignment: .leading) {
                    Text(task.title)
                        .font(.headline)
                        .strikethrough(task.isCompleted)
                        .foregroundColor(task.isCompleted ? .gray : .primary)
                    
                    if !task.description.isEmpty {
                        Text(task.description)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                }
                
                Spacer()
                
                if task.isCompleted {
                    Image(systemName: "checkmark")
                        .foregroundColor(.green)
                }
            }
        }
        .sheet(isPresented: $showingEditTask) {
            TaskEditView(task: task) { updatedTask in
                if let task = updatedTask {
                    appState.updateTask(task)
                }
            }
        }
    }
    
    private var priorityColor: Color {
        switch task.priority {
        case .high:
            return .red
        case .medium:
            return .orange
        case .low:
            return .blue
        }
    }
}

#Preview {
    TaskRowView(
        task: Task(
            id: UUID(),
            title: "Test Task",
            description: "Complete",
            date: Date.now,
            isCompleted: false,
            priority: .medium
        )
    )
    .padding()
    
    TaskRowView(
        task: Task(
            id: UUID(),
            title: "Test Task 2",
            description: "Complete ASAP",
            date: Date.now,
            isCompleted: true,
            priority: .high
        )
    )
    .padding()
}
