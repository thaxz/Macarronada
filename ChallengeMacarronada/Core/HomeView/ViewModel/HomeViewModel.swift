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
    
    @Published var defaultTasks: [Task] = []
    
    @Published var morningTasks: [Task] = [
        Task(text: "Morning Task", shift: .morning, isCompleted: false),
        Task(text: "Morning Task", shift: .morning, isCompleted: false),
    ]
    
    @Published var eveningTasks: [Task] = [
        Task(text: "Evening Task", shift: .evening, isCompleted: false),
        Task(text: "Evening Task", shift: .evening, isCompleted: false),
    ]
    
    @Published var nightTasks: [Task] = [
        Task(text: "Night Task", shift: .night, isCompleted: false),
        Task(text: "Night Task", shift: .night, isCompleted: false),
    ]
    
    
    
}


