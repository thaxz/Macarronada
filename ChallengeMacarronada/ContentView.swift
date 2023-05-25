//
//  ContentView.swift
//  ChallengeMacarronada
//
//  Created by thaxz on 23/05/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.morning
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.pink)
                Text("hello")
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
