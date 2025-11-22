import Foundation
import Combine
import CoreData

class ARDataController: ObservableObject {
    @Published var container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "ROOMARTIA2")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }

    func save(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving Core Data context: \(error)")
            }
        }
    }
}
