//
//  HomeView.swift
//  ChallengeMacarronada
//
//  Created by thaxz on 25/05/23.
//

import SwiftUI
import UserNotifications

struct HomeView: View {
  //  @State var teste: FocusState.Binding =
    @State var isPopover: Bool = false
    @State var text = ""
    @State var checkEmptytext: Bool = false
    @EnvironmentObject var viewModel: PersistentStore
    
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
                    VStack(spacing: 0){
                        if checkEmptytext {
                            Text(LocalizedStringKey("emptyTextKey"))
                                .italic()
                                .font(.system(size: 12, weight: .light))
                                .foregroundColor(Color.theme.text)
                                .padding(20)
                        }
                        listSection
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            .onChange(of: viewModel.selectedDate) { newValue in
                viewModel.saveData()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(PersistentStore())
    }
}

// MARK: Components

extension HomeView {
    
    private var calendarSection: some View {
        ZStack {
            HStack{
                Spacer()
                Button {
                    self.isPopover.toggle()
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .resizable()
                        .frame(width: 16, height: 16)
                }.popover(isPresented: self.$isPopover, arrowEdge: .bottom) {
                    VStack{
                        Text(LocalizedStringKey("closeKey"))
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color.theme.text)
                    }
                    .frame(width: 100, height: 30)
                    .onTapGesture {
                        NSApplication.shared.terminate(self)
                    }
                }.buttonStyle(PlainButtonStyle())
            }
            
            if viewModel.selectedDate.stripTime() != viewModel.today.stripTime() {
                HStack(alignment: .center){
                    Button {
                        viewModel.selectedDate = viewModel.today
                        } label: {
                            Text(LocalizedStringKey("goToTodayKey"))
                                .underline()
                                .font(.system(size: 12, weight: .light))
                                .padding(.leading, 4)
                                .foregroundColor(viewModel.selectedShift.color)
                    }
                        .buttonStyle(.plain)
                    Spacer()
                }
            }
            HStack(alignment: .center, spacing: 12){
                Spacer()
                Text(viewModel.selectedDate, formatter: viewModel.dateFormatter)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color.theme.text)
                Image(systemName: "calendar")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(Color.theme.text)
                
                    .popover(isPresented: $viewModel.isPresented) {
                        DatePicker(LocalizedStringKey("selectDateKey"),
                                   selection: $viewModel.selectedDate,
                                   displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .fixedSize()
                        .tint(.pink)
                        .border(.clear)
                        //.padding()
                    }
                Spacer()
                
            }
            
            .onTapGesture {
                viewModel.isPresented.toggle()
            }
        }
        .padding(.top, 22)
    }
    
    private var pickerSection: some View {
        CustomSegmentedControl(selectedOption: $viewModel.selectedShift)
    }
    
    private var textfieldSection: some View {
        TextField("", text: $text)
            .placeholder(when: text.isEmpty) {
                Text(LocalizedStringKey("addNewActivityKey"))
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
                if text.count <= 4 {
                    checkEmptytext = true
                } else {
                    checkEmptytext = false
                    viewModel.createNewTask(withText: text)
                    text = ""
                }
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
                            .help(LocalizedStringKey("createNewTaskKey"))
                            .padding(.trailing, 8)
                            .foregroundColor(Color.theme.text)
                            .onTapGesture {
                                if text.count <= 4 {
                                    checkEmptytext = true
                                } else {
                                    checkEmptytext = false
                                    viewModel.createNewTask(withText: text)
                                    text = ""
                                }
                            }
                    }
                }
            )
    }
    
    private var listSection: some View {
        List {
            ForEach(viewModel.tasks) { task in
                if task.shift == viewModel.selectedShift{
                    ListRow(task: task)
                        .help(LocalizedStringKey("helpNextShiftKey"))
                        .environmentObject(PersistentStore())
                        .contextMenu {
                            Button(LocalizedStringKey("deleteActivityButtonKey")){
                                viewModel.deleteAssignmentFromContextMenu(id: task.id)
                            }
                            
                            if viewModel.selectedShift != .night{
                                Button(LocalizedStringKey("moveShiftButtonKey")){
                                    viewModel.moveShift(task: task)
                                }
                            }
                        }
                }
            }
            .onDelete(perform: { IndexSet in
                viewModel.deleteAssignment(indexSet: IndexSet)
            })
            .onMove { indices, destination in
                viewModel.tasks.move(fromOffsets: indices, toOffset: destination)
            }
        }
        .scrollContentBackground(.hidden)
        .listStyle(PlainListStyle())
    }
    
}
