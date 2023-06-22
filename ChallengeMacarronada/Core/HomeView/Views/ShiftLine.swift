//
//  ShiftLine.swift
//  ChallengeMacarronada
//
//  Created by thaxz on 26/05/23.
//

import SwiftUI

struct ShiftLine: View {
    let shift: Shifts
    let topLabel: String
    let bottomLabel: String
    
    init(shift: Shifts) {
        self.shift = shift
        switch shift {
        case .morning:
            self.topLabel = "08h"
            self.bottomLabel = "12h"
        case .evening:
            self.topLabel = "14h"
            self.bottomLabel = "18h"
        case .night:
            self.topLabel = "18h"
            self.bottomLabel = "00h"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text(topLabel)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(Color.theme.text)
            Rectangle()
                .frame(maxHeight: .infinity)
                .frame(width: 1)
                .padding(.horizontal, 8)
            Text(bottomLabel)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(Color.theme.text)
        }
    }
}

struct ShiftLine_Previews: PreviewProvider {
    static var previews: some View {
        ShiftLine(shift: .evening)
    }
}
