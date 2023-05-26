//
//  HomeView.swift
//  ChallengeMacarronada
//
//  Created by thaxz on 25/05/23.
//

import SwiftUI

struct HomeView: View {
    @State var selectedDate : Date = Date()
    @State var isPresented : Bool = false
    @State var selectedShift: Shifts = .morning
    
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    var body: some View {
        ZStack {
            Color.theme.background
            VStack {
                HStack{
                    Text(selectedDate, formatter: dateFormatter)
                    Button {
                        isPresented.toggle()
                    } label: {
                        Image(systemName: "calendar")
                    }
                    .buttonStyle(.plain)
                    .popover(isPresented: $isPresented) {
                        DatePicker("Enter date",
                                   selection: $selectedDate,
                                   displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .padding()
                        .fixedSize()
                    }
                }
                
                Picker("Shift Picker", selection: $selectedShift){
                    ForEach(Shifts.allCases){ shift in
                        Text(shift.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                    .labelsHidden()
                
                Spacer()
            }
        }
        .frame(width: 390, height: 624)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
