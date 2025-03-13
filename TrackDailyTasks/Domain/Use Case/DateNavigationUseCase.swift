//
//  DateNavigationUseCase.swift
//  TrackDailyTasks
//
//  Created by Arslan Yazlyyev on 3/12/25.
//

import Foundation

class DateNavigationUseCase: DateNavigationUseCaseProtocol {
    func getCurrentDate() -> Date {
        return Date()
    }
    
    func getNextDay(from date: Date) -> Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: date) ?? date
    }
    
    func getPreviousDay(from date: Date) -> Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: date) ?? date
    }
}
