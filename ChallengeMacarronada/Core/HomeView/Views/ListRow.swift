//
//  ListRow.swift
//  ChallengeMacarronada
//
//  Created by thaxz on 26/05/23.
//

import SwiftUI

struct ListRow: View {
    @EnvironmentObject var viewModel: PersistentStore
    @State var task: Assignment
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(
                    task.isCompleted ? task.shift.color :
                        Color.theme.background
                )
                .onTapGesture {
                    task.toggleTask()
                }
            Spacer()
                .frame(width: 40)
            HStack(spacing: 14){
                Group {
                    Image(systemName:
                            task.isCompleted ? "circle.fill"
                          : "circle"
                    )
                    .resizable()
                    .frame(width: 14, height: 14)
                    
                    .foregroundColor(Color.theme.text)
                    isStrikedThrough(task.isCompleted)
                        .foregroundColor(Color.theme.text)
                        .font(.system(size: 12, weight: .regular))
                        .multilineTextAlignment(.leading)
                }
                .onTapGesture {
                    task.toggleTask()
                }
                Spacer()
                Image(systemName: "line.3.horizontal")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .foregroundColor(Color.theme.text)
            }
            .padding(.horizontal, 12)
        }
        .frame(minHeight: 56)
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(task.shift.color, lineWidth: 1)
        )
    }
    
    
    func isStrikedThrough(_ bool: Bool) -> Text {
        if bool {
            return Text(task.text)
                .strikethrough()
        } else {
            return Text(task.text)
        }
    }
    
}

//struct ListRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ListRow(task: dev.toDoTask)
//    }
//}
