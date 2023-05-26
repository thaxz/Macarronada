//
//  CustomSegmentedControl.swift
//  ChallengeMacarronada
//
//  Created by aaav on 26/05/23.
//

import SwiftUI

struct CustomSegmentedControl: View {
    @Binding var preselectedIndex: Int
    var options: [Shifts]
    let color = Color.red
    var body: some View {
        HStack(spacing: 0) {
            ForEach(options.indices, id:\.self) { index in
                ZStack {
                    Rectangle()
                        .fill(Color.theme.secondary)
                    Rectangle()
                        .fill(options[index].color)
                        .cornerRadius(9)
                        .padding(2)
                        .opacity(preselectedIndex == index ? 1 : 0.01)
                }
                .overlay(
                    Text(options[index].rawValue)
                        .foregroundColor(Color.theme.text)
                )
                .onTapGesture {
                    withAnimation(.interactiveSpring()) {
                            preselectedIndex = index
                        }
                    }

            }

        }
        .frame(height: 32)
        .cornerRadius(9)
    }
}
