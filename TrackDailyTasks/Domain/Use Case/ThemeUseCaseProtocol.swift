//
//  ThemeUseCaseProtocol.swift
//  TrackDailyTasks
//
//  Created by Arslan Yazlyyev on 3/12/25.
//


protocol ThemeUseCaseProtocol {
    func getCurrentTheme() -> Theme
    func toggleTheme() -> Theme
    func setTheme(_ theme: Theme) -> Theme
}