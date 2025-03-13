//
//  TaskRepositoryProtocol.swift
//  TrackDailyTasks
//
//  Created by Arslan Yazlyyev on 3/12/25.
//


protocol TaskRepositoryProtocol {
    func getAllTasks() -> [Task]
    func saveTask(_ task: Task)
    func updateTask(_ task: Task)
    func deleteTask(_ task: Task)
}