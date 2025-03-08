//
//  TaskRow.swift
//  Tasks
//
//  Created by Arslan Yazlyyev on 3/8/25.
//

import SwiftUI

struct TaskRow: View {
    let task: Task
    let onToggle: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                    .strikethrough(task.isCompleted)
                Text(task.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            
            Spacer()
            
            Button(action: onToggle) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.isCompleted ? .green : .gray)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    TaskRow(task: Task(
        id: UUID(),
        title: "Learn Clean Architecture",
        description: "Study the principles of Clean Architecture",
        isCompleted: false),
        onToggle: {}
    )
}
