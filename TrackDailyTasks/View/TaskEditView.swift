//
//  TaskEditView.swift
//  TrackDailyTasks
//
//  Created by Arslan Yazlyyev on 3/12/25.
//

import SwiftUI

struct TaskEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject private var appState: AppState
    
    private var initialTask: Task?
    private var onSave: (Task?) -> Void
    
    @State private var title = ""
    @State private var description = ""
    @State private var date: Date
    @State private var priority: TaskPriority = .medium
    @State private var isCompleted = false
    
    init(task: Task?, onSave: @escaping (Task?) -> Void) {
        self.initialTask = task
        self.onSave = onSave
        
        // Initialize state
        _title = State(initialValue: task?.title ?? "")
        _description = State(initialValue: task?.description ?? "")
        _date = State(initialValue: task?.date ?? Date())
        _priority = State(initialValue: task?.priority ?? .medium)
        _isCompleted = State(initialValue: task?.isCompleted ?? false)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Title", text: $title)
                        .textFieldStyle(.roundedBorder)
                    TextField("Description", text: $description, axis: .vertical)
                        .lineLimit(7, reservesSpace: true)
                        .textFieldStyle(.roundedBorder)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }
                .padding(.all, 12)
                
                Section(header: Text("Priority")) {
                    Picker("Priority", selection: $priority) {
                        Text("Low").tag(TaskPriority.low)
                        Text("Medium").tag(TaskPriority.medium)
                        Text("High").tag(TaskPriority.high)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                if initialTask != nil {
                    Section {
                        Toggle("Completed", isOn: $isCompleted)
                    }
                }
            }
            .navigationTitle(initialTask == nil ? "New Task" : "Edit Task")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss(savingTask: nil)
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveTask()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
    
    private func saveTask() {
        let task = Task(
            id: initialTask?.id ?? UUID(),
            title: title.trimmingCharacters(in: .whitespacesAndNewlines),
            description: description.trimmingCharacters(in: .whitespacesAndNewlines),
            date: date,
            isCompleted: isCompleted,
            priority: priority
        )
        
        dismiss(savingTask: task)
    }
    
    private func dismiss(savingTask task: Task?) {
        onSave(task)
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    TaskEditView(
        task: Task(title: "Test", date: Date()),
        onSave: { _ in }
    )
}
