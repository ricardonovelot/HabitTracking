//
//  Habits.swift
//  HabitTracking
//
//  Created by Ricardo on 16/01/24.
//

import Foundation

struct Habit: Identifiable,Equatable {
    var id = UUID()
    var name: String
    var description: String
    var amount: Int
}
