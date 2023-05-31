//
//  Task.swift
//  ChallengeMacarronada
//
//  Created by thaxz on 25/05/23.
//

import Foundation

struct Assignment: Identifiable {
    
    let id : String
    let text: String
    let shift: Shifts
    var isCompleted: Bool
    
    mutating func toggleTask(){
        isCompleted.toggle()
    }
    
}
