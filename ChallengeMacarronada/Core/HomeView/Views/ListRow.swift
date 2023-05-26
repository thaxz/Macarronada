//
//  ListRow.swift
//  ChallengeMacarronada
//
//  Created by thaxz on 26/05/23.
//

import SwiftUI

struct ListRow: View {
    let task: Task
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.theme.evening)
                .frame(minHeight: 56)
            HStack(spacing: 14){
                Image(systemName: "circle")
                    .resizable()
                    .frame(width: 14, height: 14)
                    .foregroundColor(Color.theme.text)
                Text("pipip popo")
                    .font(.system(size: 12, weight: .regular))
                Spacer()
                Image(systemName: "line.3.horizontal")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .foregroundColor(Color.theme.text)
            }
            .padding(.horizontal, 12)
        }
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(task: dev.toDoTask)
    }
}
