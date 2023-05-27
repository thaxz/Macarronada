//
//  HomeView.swift
//  ChallengeMacarronada
//
//  Created by thaxz on 25/05/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel: HomeViewModel
    @State var text = ""
    
    init(){
        _viewModel = StateObject(wrappedValue: HomeViewModel())
    }
    
    var body: some View {
        ZStack {
            Color.theme.background
            VStack(spacing: 12){
                calendarSection
                pickerSection
                textfieldSection
                HStack {
                    ShiftLine(shift: viewModel.selectedShift)
                    Spacer()
                    listSection
                }
                Spacer()
            }
            .padding(.horizontal, 24)
        }
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
            Text(viewModel.selectedDate, formatter: viewModel.dateFormatter)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color.theme.text)
            Button {
                viewModel.isPresented.toggle()
            } label: {
                Image(systemName: "calendar")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(Color.theme.text)
            }
            .buttonStyle(.plain)
            .popover(isPresented: $viewModel.isPresented) {
                DatePicker("Enter date",
                           selection: $viewModel.selectedDate,
                           displayedComponents: [.date])
                .datePickerStyle(.graphical)
                .labelsHidden()
                .fixedSize()
                .padding()
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
        CustomSegmentedControl(selectedOption: $viewModel.selectedShift)
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
            .onSubmit {
                viewModel.createNewTask(withText: text)
                text = ""
            }
            .onExitCommand(perform: {
                text = ""
            })
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
                                viewModel.createNewTask(withText: text)
                                text = ""
                            }
                    }
                }
            )
    }
    
    private var listSection: some View {
            List {
                ForEach(viewModel.tasks) { task in
                    ListRow(task: task)
                }
                .onMove { indices, destination in
                    viewModel.tasks.move(fromOffsets: indices, toOffset: destination)
                }
            }
            .scrollContentBackground(.hidden)
            .listStyle(PlainListStyle())
        }
    
}
