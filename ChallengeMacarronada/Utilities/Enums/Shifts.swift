//
//  Shifts.swift
//  ChallengeMacarronada
//
//  Created by thaxz on 25/05/23.
//

import Foundation
import SwiftUI

enum Shifts : String, CaseIterable, Identifiable {

    case morning = "Manhã"
    case evening = "Tarde"
    case night = "Noite"
    
    var id: Self {self}
    
}
