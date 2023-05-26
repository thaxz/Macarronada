//
//  HomeView.swift
//  ChallengeMacarronada
//
//  Created by thaxz on 25/05/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel: HomeViewModel
    
    init(){
        _viewModel = StateObject(wrappedValue: HomeViewModel())
    }
    
    @State private var tasks: [Task] = []
    
    @State var selectedDate : Date = Date()
    @State var isPresented : Bool = false
   // @State var selectedShift: Shifts = .morning
    @State var selectedIndex : Int = 0
    @State var text = ""
    
    var selectedShift: Shifts {
        Shifts.allCases[selectedIndex]
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    var body: some View {
        ZStack {
            Color.theme.background
            VStack(spacing: 12){
                calendarSection
                pickerSection
                textfieldSection
                HStack {
                    ShiftLine(shift: .evening)
                    Spacer()
                    List {
                        ForEach(self.tasks) { task in
                            ListRow(task: task)
                        }
                        
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(PlainListStyle())
                }                
                Spacer()
            }
            .padding(.horizontal, 24)
        }
        .onChange(of: selectedIndex, perform: { newValue in
            if selectedIndex == 0 {
                self.tasks = viewModel.morningTasks
            } else if selectedIndex == 1 {
                self.tasks = viewModel.eveningTasks
            } else {
                self.tasks = viewModel.nightTasks
            }
        })
        .frame(width: 390, height: 624)
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

// MARK: Components

extension HomeView {
    
    private var calendarSection: some View {
        HStack(alignment: .center, spacing: 12){
            Spacer()
            Text(selectedDate, formatter: dateFormatter)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color.theme.text)
            Button {
                isPresented.toggle()
            } label: {
                Image(systemName: "calendar")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(Color.theme.text)
            }
            .buttonStyle(.plain)
            .popover(isPresented: $isPresented) {
                DatePicker("Enter date",
                           selection: $selectedDate,
                           displayedComponents: [.date])
                .datePickerStyle(.graphical)
                .labelsHidden()
                .frame(width: 200 ,height: 200)
            }
            
            Spacer()
            
            Image(systemName: "ellipsis.circle")
                .resizable()
                .frame(width: 18, height: 18)
                .foregroundColor(Color.theme.text)
        }
        .padding(.top, 22)
    }
    
    private var pickerSection: some View {
        CustomSegmentedControl(preselectedIndex: $selectedIndex, options: Shifts.allCases)
    }
        
    private var textfieldSection: some View {
        TextField("", text: $text)
            .placeholder(when: text.isEmpty) {
                Text("Adicionar nova atividade")
                    .italic()
                    .font(.system(size: 12, weight: .light))
                    .padding(.leading, 4)
                    .foregroundColor(Color.theme.text)
            }
            .frame(height: 32)
            .textFieldStyle(PlainTextFieldStyle())
            .foregroundColor(Color.theme.text)
            .padding([.horizontal], 8)
            .cornerRadius(8)
            .overlay(
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.theme.text)
                    HStack {
                        Spacer()
                        Image(systemName: "plus")
                            .padding(.trailing, 8)
                            .foregroundColor(Color.theme.text)
                            .onTapGesture {
                                // create new task
                            }
                    }
                }
                
            )
    }

    
    
}
