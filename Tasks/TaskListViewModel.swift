//
//  TaskListViewModel.swift
//  Tasks
//
//  Created by Arslan Yazlyyev on 3/8/25.
//


// TaskListViewModel.swift
import SwiftUI

class TaskListViewModel: ObservableObject {
    private var presenter: TaskListPresenterProtocol
    
    @Published var tasks: [Task] = []
    
    init(presenter: TaskListPresenterProtocol) {
        self.presenter = presenter
        self.presenter.onTasksUpdated = { [weak self] in
            self?.tasks = self?.presenter.tasks ?? []
        }
    }
    
    func viewDidLoad() {
        presenter.viewDidLoad()
    }
    
    func addTask(title: String, description: String) {
        presenter.addTask(title: title, description: description)
    }
    
    func toggleTaskCompletion(task: Task) {
        presenter.toggleTaskCompletion(task: task)
    }
}
