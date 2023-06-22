//
//  FreeTimeModal.swift
//  ChallengeMacarronada
//
//  Created by thaxz on 29/05/23.
//

import SwiftUI

struct FreeTimeModal: View {
    
    let shift: Shifts
    let image: String
    let title: String
    let message: String
    let seeActivities: () -> Void
    
    init(shift: Shifts, seeActivities: @escaping () -> Void){
        self.seeActivities = seeActivities
        self.shift = shift
        switch shift {
        case .morning:
            self.image = "morningImage"
            self.title = "Error"
            self.message = "Error"
        case .evening:
            self.image = "lunchImage"
            self.title = "Show!"
            self.message = "Bom almoço, aproveite o descanso e até já :)"
        case .night:
            self.image = "dinnerImage"
            self.title = "Massa!"
            self.message = "Boa noite, lembre-se de descansar e até amanhã!"
        }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.theme.background)
            VStack(spacing: 16){
                Image(image)
                    .resizable()
                    .frame(width: 140, height: 140)
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color.theme.text)
                Text(message)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(Color.theme.text)
                    .multilineTextAlignment(.center)
                Button {
                    seeActivities()
                } label: {
                    Text("Ver Atividades")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(shift.color)
                        .underline()
                } .buttonStyle(PlainButtonStyle())
            }
            .padding(40)
        }
        .frame(width: 245, height: 340)
    }
}

struct FreeTimeModal_Previews: PreviewProvider {
    static var previews: some View {
        FreeTimeModal(shift: .evening, seeActivities: {})
    }
}
