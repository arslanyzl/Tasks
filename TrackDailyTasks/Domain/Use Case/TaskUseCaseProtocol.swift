//
//  TaskUseCaseProtocol.swift
//  TrackDailyTasks
//
//  Created by Arslan Yazlyyev on 3/12/25.
//

import Foundation

protocol TaskUseCaseProtocol {
    func getTasks(for date: Date) -> [Task]
    func addTask(_ task: Task)
    func updateTask(_ task: Task)
    func deleteTask(_ task: Task)
}
