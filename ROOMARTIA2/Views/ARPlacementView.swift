import SwiftUI
import UIKit
import CoreData

struct ARPlacementView: View {
    let item: FurnitureItem

    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject private var dataController: ARDataController

    @State private var title: String = ""
    @State private var showSavedAlert = false

    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer(item: item)
                .ignoresSafeArea()

            VStack(spacing: 12) {
                TextField("Name this placement (e.g. Living Room Setup)",
                          text: $title)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .padding(.top, 8)

                Button {
                    savePlacement()
                } label: {
                    Label("Save Placement", systemImage: "square.and.arrow.down")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding()

            }
            .background(.ultraThinMaterial)
        }
        .alert("Saved!", isPresented: $showSavedAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Your placement has been saved to the history.")
        }
    }

    private func savePlacement() {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let placement = Placement(context: context)
        placement.id = UUID()
        placement.title = trimmed
        placement.itemName = item.name
        placement.date = Date()

        dataController.save(context: context)
        showSavedAlert = true
        title = ""
    }
}

#Preview {
    ARPlacementView(item: sampleItems.first!)
        .environment(\.managedObjectContext,
                      ARDataController().container.viewContext)
        .environmentObject(ARDataController())
}
