//
//  TaskListPresenterProtocol.swift
//  Tasks
//
//  Created by Arslan Yazlyyev on 3/8/25.
//

protocol TaskListPresenterProtocol {
    func viewDidLoad()
    func addTask(title: String, description: String)
    func toggleTaskCompletion(task: Task)
    
    var tasks: [Task] { get }
    var onTasksUpdated: (() -> Void)? { get set }
}

class TaskListPresenter: TaskListPresenterProtocol {
    private let getTasksUseCase: GetTasksUseCase
    private let addTaskUseCase: AddTaskUseCase
    private let updateTaskUseCase: UpdateTaskUseCase
    
    private(set) var tasks: [Task] = []
    var onTasksUpdated: (() -> Void)?
    
    init(getTasksUseCase: GetTasksUseCase, 
         addTaskUseCase: AddTaskUseCase, 
         updateTaskUseCase: UpdateTaskUseCase) {
        self.getTasksUseCase = getTasksUseCase
        self.addTaskUseCase = addTaskUseCase
        self.updateTaskUseCase = updateTaskUseCase
    }
    
    func viewDidLoad() {
        loadTasks()
    }
    
    func addTask(title: String, description: String) {
        let newTask = Task(title: title, description: description)
        let success = addTaskUseCase.execute(task: newTask)
        
        if success {
            loadTasks()
        }
    }
    
    func toggleTaskCompletion(task: Task) {
        var updatedTask = task
        updatedTask.isCompleted.toggle()
        
        let success = updateTaskUseCase.execute(task: updatedTask)
        
        if success {
            loadTasks()
        }
    }
    
    private func loadTasks() {
        tasks = getTasksUseCase.execute()
        onTasksUpdated?()
    }
}
