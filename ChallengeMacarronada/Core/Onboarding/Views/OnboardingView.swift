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
                
                Image(systemName: "ellipsis.circle")
                    .resizable()
                    .frame(width: 150, height: 150)
                    
                
                Spacer()
            }
            .padding(24)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
