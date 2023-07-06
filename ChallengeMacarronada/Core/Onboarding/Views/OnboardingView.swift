//
//  OnboardingView.swift
//  Bell
//
//  Created by thaxz on 05/07/23.
//

import SwiftUI

struct OnboardingView: View {
    @State var action: () -> Void
    @State var isPopover: Bool = false
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack(spacing: 16){
                seeMoreSection
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
                   action()
                    NSApplication.shared.mainWindow?.close()
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.theme.evening)
                        Text("Começar a usar Bell")
                            .font(.system(size: 14, weight: .semibold))
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

extension OnboardingView {
    
    
    private var seeMoreSection: some View{
        HStack{
            Spacer()
            Button {
                self.isPopover.toggle()
            } label: {
                Image(systemName: "ellipsis.circle")
                    .resizable()
                    .frame(width: 24, height: 24)
            }.popover(isPresented: self.$isPopover, arrowEdge: .bottom) {
                VStack{
                    Text("Fechar Bell")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color.theme.text)
                }
                .frame(width: 100, height: 30)
                .onTapGesture {
                    NSApplication.shared.terminate(self)
                }
            }.buttonStyle(PlainButtonStyle())
        }
    }
    
}


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(action: {})
    }
}
