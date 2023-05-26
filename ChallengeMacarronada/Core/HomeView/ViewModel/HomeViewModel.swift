//
//  HomeViewModel.swift
//  ChallengeMacarronada
//
//  Created by thaxz on 25/05/23.
//

import Foundation
import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject {
    
    @Published var selectedIndex: Int = 0
    
    var selectedShift: Shifts {
        Shifts.allCases[selectedIndex]
    }
    
    var tasks: [Task] {
        switch selectedShift {
        case .morning:
            return morningTasks
        case .evening:
            return eveningTasks
        case .night:
            return nightTasks
        }
    }
    
    @Published var selectedDate: Date = Date()
    @Published var isPresented: Bool = false
    @Published var text = ""
    
    private var morningTasks: [Task] = [
        Task(text: "Morning Task", shift: .morning, isCompleted: false),
        Task(text: "Morning Task", shift: .morning, isCompleted: false),
    ]
    
    private var eveningTasks: [Task] = [
        Task(text: "Evening Task", shift: .evening, isCompleted: false),
        Task(text: "Evening Task", shift: .evening, isCompleted: false),
    ]
    
    private var nightTasks: [Task] = [
        Task(text: "Night Task", shift: .night, isCompleted: false),
        Task(text: "Night Task", shift: .night, isCompleted: false),
    ]
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    
}



