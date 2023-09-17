//
//  CustomSegmentedController.swift
//  Bell
//
//  Created by thaxz on 17/09/23.
//

import SwiftUI

struct CustomSegmentedControl: View {
    @Binding var selectedOption: Shifts
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Shifts.allCases, id: \.self) { option in
                ZStack {
                    Rectangle()
                        .fill(Color.theme.secondary)
                    Rectangle()
                        .fill(option.color)
                        .cornerRadius(9)
                        .padding(2)
                        .opacity(option == selectedOption ? 1 : 0.01)
                }
                .overlay(
                    Text(option.rawValue)
                        .foregroundColor(colorScheme == .dark ? Color.theme.text : (option == selectedOption ? Color.white : Color.gray))
                )
                .onTapGesture {
                    withAnimation(.interactiveSpring()) {
                        selectedOption = option
                    }
                }
            }
        }
        .frame(height: 32)
        .cornerRadius(9)
    }
}
