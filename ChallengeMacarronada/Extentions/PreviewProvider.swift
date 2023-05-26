//
//  PreviewProvider.swift
//  ChallengeMacarronada
//
//  Created by thaxz on 26/05/23.
//

import Foundation
import SwiftUI

extension PreviewProvider{
    static var dev: DeveloperPreview{
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    private init() {}
 
    
    let concludedTask: Task = Task(text: "Eu sou uma task conlcuida", shift: .evening, isCompleted: true)
    
    let toDoTask: Task = Task(text: "Eu sou uma task a se fazer", shift: .evening, isCompleted: false)
    
}
