//
//  OnboardingView.swift
//  Bell
//
//  Created by thaxz on 05/07/23.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack(spacing: 16){
                HStack{
                    Spacer()
                    Image(systemName: "ellipsis.circle")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(Color.theme.text)
                }
                Image("bellBird")
                    .resizable()
                    .frame(width: 150, height: 150)
                Spacer()
                    .frame(height: 30)
                Text("Seja bem vindo a Bell")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(Color.theme.text)
                Text("Bell divide o dia em turnos através de uma interface prática e manda notificações ao longo do dia para simplificar o seu processo de organização.")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color.theme.text)
                    .multilineTextAlignment(.center)
                Spacer()
                    .frame(height: 30)
                Button {
                    
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.theme.evening)
                        Text("Começar a usar Bell")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color.theme.text)
                    }
                    .frame(width: 220, height: 40)
                } .buttonStyle(PlainButtonStyle())

                
                Spacer()
            }
            .padding(32)
        }
        .frame(width: 390, height: 624)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
