import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("ROOMARTIA2App")
                    .font(.largeTitle.bold())
                    .padding(.top)

                Text("Preview furniture in your real room using Augmented Reality.")
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                NavigationLink("Start with Catalog") {
                    CatalogView()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)

                NavigationLink("View Saved Placements") {
                    SavedPlacementsView()
                }
                .buttonStyle(.bordered)

                Spacer()
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}

