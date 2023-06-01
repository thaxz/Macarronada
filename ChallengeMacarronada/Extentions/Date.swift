//
//  Date.swift
//  ChallengeMacarronada
//
//  Created by aaav on 31/05/23.
//

import Foundation

extension Date {

    func stripTime() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let date = Calendar.current.date(from: components)
        return date!
    }

}
