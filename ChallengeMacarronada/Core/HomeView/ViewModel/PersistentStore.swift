//
//  PersistentStore.swift
//  ChallengeMacarronada
//
//  Created by aaav on 30/05/23.
//
import SwiftUI
import CoreData
import Foundation

@MainActor
final class PersistentStore : ObservableObject {

    let container: NSPersistentContainer
    @Published var displayedAssignments : [AssignmentEntity] = []
    @Published var selectedShift : Shifts = .morning
    @Published var tasks: [Assignment] = []
    @Published var selectedDate: Date = Date()
    @Published var isPresented: Bool = false
    @Published var today: Date = Date()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    init() {
        container = NSPersistentContainer(name: "Macarronada")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                print(error)
            }
        }
        fetchAssignment()
    }
    
    func fetchAssignment(){
        let request = NSFetchRequest<AssignmentEntity>(entityName: "AssignmentEntity")
        //    https://nspredicate.xyz/
        request.predicate = NSPredicate(format: "taskDate == %@", self.selectedDate.stripTime() as CVarArg)
        
        do {
            displayedAssignments = try container.viewContext.fetch(request)
            tasks = displayedAssignments.map { Assignment(id: $0.id!, text: $0.text!, shift: Shifts(rawValue: $0.shift!)!, isCompleted: $0.isCompleted, taskDate: $0.taskDate!) }
        } catch let error {
            print(error)
        }
    }
    
    func createNewTask(withText text: String){

        let newAssignment = AssignmentEntity(context: container.viewContext)
        
        newAssignment.id = UUID().uuidString
        newAssignment.text = text
        newAssignment.shift = self.selectedShift.rawValue
        newAssignment.isCompleted = false
        newAssignment.taskDate = selectedDate.stripTime()
        
        saveData()
    }
    
    func saveData(){
        do {
            try container.viewContext.save()
            fetchAssignment()
        } catch let error{
            print("error saving \(error)")
        }
    }
    
    func deleteAssignment(indexSet: IndexSet){
        guard let index = indexSet.first else {return}
        let entity = displayedAssignments[index]
        container.viewContext.delete(entity)

        saveData()
    }
    
    func deleteAssignmentFromContextMenu(id: String){
        for entity in displayedAssignments{
            if entity.id == id{
                container.viewContext.delete(entity)
                saveData()
            }
        }
        
    }
    
    func copyShift(task: Assignment){
        let newAssignment = AssignmentEntity(context: container.viewContext)
        var newShift = task.shift
        
        switch newShift {
        case .morning:
            newShift = .evening
            break
        case .evening:
            newShift = .night
            break
        case .night:
            break
        }

        newAssignment.id = UUID().uuidString
        newAssignment.text = task.text
        newAssignment.shift = newShift.rawValue
        newAssignment.isCompleted = task.isCompleted
        newAssignment.taskDate = task.taskDate

    }
    
    func moveShift(task: Assignment){
        copyShift(task: task)
        deleteAssignmentFromContextMenu(id: task.id)
        saveData()
    }
    

}
