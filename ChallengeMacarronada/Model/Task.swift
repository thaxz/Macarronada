//
//  Task.swift
//  ChallengeMacarronada
//
//  Created by thaxz on 25/05/23.
//

import Foundation

struct Task: Identifiable {
    
    let id = UUID().uuidString
    let text: String
    let shift: Shifts
    var isCompleted: Bool
    
    mutating func toggleTask(){
        isCompleted.toggle()
    }
    
}
