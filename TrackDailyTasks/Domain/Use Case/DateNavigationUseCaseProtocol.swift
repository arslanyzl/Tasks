//
//  DateNavigationUseCaseProtocol.swift
//  TrackDailyTasks
//
//  Created by Arslan Yazlyyev on 3/12/25.
//

import Foundation

protocol DateNavigationUseCaseProtocol {
    func getCurrentDate() -> Date
    func getNextDay(from date: Date) -> Date
    func getPreviousDay(from date: Date) -> Date
}
