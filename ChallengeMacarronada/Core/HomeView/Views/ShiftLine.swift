//
//  ShiftLine.swift
//  ChallengeMacarronada
//
//  Created by thaxz on 26/05/23.
//

import SwiftUI

struct ShiftLine: View {
    
    let shift: Shifts?
    let topLabel: LocalizedStringKey
    let bottomLabel: LocalizedStringKey
    
    init(shift: Shifts ) {
        self.shift = shift
        switch shift {
        case .morning:
            self.topLabel = LocalizedStringKey("topLbMorningKey")
            self.bottomLabel = LocalizedStringKey("bottomLbMorningKey")
        case .evening:
            self.topLabel = LocalizedStringKey("topLbEveningKey")
            self.bottomLabel = LocalizedStringKey("bottomLbEveningKey")
        case .night:
            self.topLabel = LocalizedStringKey("topLbNightKey")
            self.bottomLabel = LocalizedStringKey("bottomLbNightKey")
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
