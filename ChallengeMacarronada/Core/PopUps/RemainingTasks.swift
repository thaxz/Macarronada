//
//  RemainingTasks.swift
//  ChallengeMacarronada
//
//  Created by thaxz on 29/05/23.
//

import SwiftUI

struct RemainingTasks: View {
    let rearrange: () -> Void
    let dontRearrange: () -> Void
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.theme.background)
            VStack(spacing: 8){
                Image("morningImage")
                    .resizable()
                    .frame(width: 195, height: 150)
                Spacer()
                Text("Bom dia!")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color.theme.text)
                Text("Você deseja remanejar as atividades que sobraram ontem para hoje?")
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(Color.theme.text)
                    .multilineTextAlignment(.center)
                Spacer()
                HStack(spacing: 12){
                    Button {
                        rearrange()
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.theme.morning)
                                .frame(width: 50, height: 22)
                            Text("Sim")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(Color.theme.text)
                        }
                    } .buttonStyle(PlainButtonStyle())
                    Button {
                        dontRearrange()
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.theme.secondary)
                                .frame(width: 50, height: 22)
                            Text("Não")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(Color.theme.text)
                        }
                    } .buttonStyle(PlainButtonStyle())
                }
                Spacer()
            }
            .padding(.horizontal , 24)
            .padding(.top , 24)
        }
        .frame(width: 245, height: 340)
    }
}

struct RemainingTasks_Previews: PreviewProvider {
    static var previews: some View {
        RemainingTasks(rearrange: {}, dontRearrange: {})
    }
}
