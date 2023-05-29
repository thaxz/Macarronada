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
    
    @Published var selectedShift: Shifts = .morning
    
    var tasks: [Assignment] {
        get {
            switch selectedShift {
            case .morning:
                return morningTasks
            case .evening:
                return eveningTasks
            case .night:
                return nightTasks
            }
        }
        set {
            switch selectedShift {
            case .morning:
                morningTasks = newValue
            case .evening:
                eveningTasks = newValue
            case .night:
                nightTasks = newValue
            }
        }
    }
    
    @Published var selectedDate: Date = Date()
    @Published var isPresented: Bool = false
    
    @Published private var morningTasks: [Assignment] = [
        Assignment(text: "Morning Task", shift: .morning, isCompleted: false),
        Assignment(text: "Morning Task", shift: .morning, isCompleted: false),
    ]
    
    @Published  private var eveningTasks: [Assignment] = [
        Assignment(text: "Evening Task", shift: .evening, isCompleted: false),
        Assignment(text: "Evening Task", shift: .evening, isCompleted: false),
    ]
    
    @Published private var nightTasks: [Assignment] = [
        Assignment(text: "Night Task", shift: .night, isCompleted: false),
        Assignment(text: "Night Task", shift: .night, isCompleted: false),
    ]
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    func createNewTask(withText text: String) {
            let newTask = Assignment(text: text, shift: selectedShift, isCompleted: false)
        
            switch selectedShift {
            case .morning:
                morningTasks.append(newTask)
            case .evening:
                eveningTasks.append(newTask)
            case .night:
                nightTasks.append(newTask)
            }
        }
    
    
}



