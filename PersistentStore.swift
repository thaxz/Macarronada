//
//  PersistentStore.swift
//  ChallengeMacarronada
//
//  Created by aaav on 30/05/23.
//
import SwiftUI
import CoreData
import Foundation

class PersistentStore : ObservableObject {

    let container: NSPersistentContainer
    var displayedAssignments : [AssignmentEntity] = []
    @Published var selectedShift : Shifts = .morning
    @Published var tasks: [Assignment] = []
    @Published var selectedDate: Date = Date()
    @Published var isPresented: Bool = false
    
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
//        request.predicate = NSPredicate(format: "isCompleted == NO")
//        request.predicate = NSPredicate(format: "shift == %@", self.selectedShift.rawValue)
//        request.predicate = NSPredicate(format: "taskDate == %@", self.selectedDate)
        
        do {
            displayedAssignments = try container.viewContext.fetch(request)
            tasks = displayedAssignments.map { Assignment(id: $0.id!, text: $0.text!, shift: Shifts(rawValue: $0.shift!)!, isCompleted: $0.isCompleted) }
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
        newAssignment.taskDate = selectedDate
        
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
            print(entity.id, id)
            
            if entity.id == id{
                container.viewContext.delete(entity)
                saveData()
            }
        }
        
    }
    
    func taskToggle(id : String){
        
    }

}
