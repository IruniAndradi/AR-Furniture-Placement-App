import SwiftUI
import UIKit
import CoreData

struct SavedPlacementsView: View {
    @Environment(\.managedObjectContext) private var context

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Placement.date, ascending: false)]
    ) private var placements: FetchedResults<Placement>

    var body: some View {
        List {
            ForEach(placements) { placement in
                VStack(alignment: .leading, spacing: 4) {
                    Text((placement.title as? String) ?? "Untitled")
                        .font(.headline)
                    Text((placement.itemName as? String) ?? "")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    if let date = placement.date {
                        Text(date.formatted(date: .abbreviated, time: .shortened))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 6)
            }
            .onDelete(perform: deleteItems)
        }
        .navigationTitle("Saved Placements")
        .toolbar {
            EditButton()
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        offsets.map { placements[$0] }.forEach(context.delete)
        do {
            try context.save()
        } catch {
            print("Error deleting: \(error)")
        }
    }
}

#Preview {
    struct PreviewContainer: View {
        let container: NSPersistentContainer
        init() {
            container = NSPersistentContainer(name: "Model")
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [description]
            container.loadPersistentStores { _, _ in }
        }
        var body: some View {
            NavigationStack {
                SavedPlacementsView()
                    .environment(\.managedObjectContext, container.viewContext)
            }
        }
    }
    return PreviewContainer()
}
