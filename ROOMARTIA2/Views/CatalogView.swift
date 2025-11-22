import SwiftUI

struct CatalogView: View {
    @State private var selectedItem: FurnitureItem?

    var body: some View {
        List {
            ForEach(sampleItems) { item in
                Button {
                    withAnimation(.spring) {
                        selectedItem = item
                    }
                } label: {
                    HStack(spacing: 16) {
                        Image(systemName: item.icon)
                            .font(.title2)
                            .padding(10)
                            .background(item.accentColor.opacity(0.2))
                            .clipShape(Circle())

                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.description)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.secondary)
                    }
                    .cardStyle()
                }
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .navigationTitle("Catalog")
        .sheet(item: $selectedItem) { item in
            NavigationStack {
                ARPlacementView(item: item)
                    .navigationTitle(item.name)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Close") { selectedItem = nil }
                        }
                    }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CatalogView()
    }
}
