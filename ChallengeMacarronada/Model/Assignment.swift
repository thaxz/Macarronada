//
//  Task.swift
//  ChallengeMacarronada
//
//  Created by thaxz on 25/05/23.
//

import Foundation

struct Assignment: Identifiable {
    
    let id : String
    var text: String
    var shift: Shifts
    var isCompleted: Bool
    var taskDate: Date
    
    mutating func toggleTask(){
        isCompleted.toggle()
    }
    
}
