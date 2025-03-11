//
//  AddTaskView.swift
//  Tasks
//
//  Created by Arslan Yazlyyev on 3/8/25.
//


import SwiftUI

struct AddTaskView: View {
    @Binding var isPresented: Bool
    @State var title: String = ""
    @State var description: String = ""
    var taskToEdit: Task?
    let onSave: (Task) -> Void

    init(isPresented: Binding<Bool>, taskToEdit: Task? = nil, onSave: @escaping (Task) -> Void) {
        self._isPresented = isPresented
        self.taskToEdit = taskToEdit
        self.onSave = onSave
        _title = State(initialValue: taskToEdit?.title ?? "")
        _description = State(initialValue: taskToEdit?.description ?? "")
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle(taskToEdit == nil ? "Add Task" : "Edit Task")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Button(taskToEdit == nil ? "Add" : "Save") {
                            let updatedTask = Task(id: taskToEdit?.id ?? UUID(), title: title, description: description, isCompleted: taskToEdit?.isCompleted ?? false)
                            onSave(updatedTask)
                            isPresented = false
                        }
                        .disabled(title.isEmpty)
                    }
                }
            }
        }
    }
}


//#Preview {
//    AddTaskView(
//        isPresented: .constant(true),
//        taskToEdit: Task(title: "Clean", description: "Work"),
//        onSave: { _ in }
//    )
//}
