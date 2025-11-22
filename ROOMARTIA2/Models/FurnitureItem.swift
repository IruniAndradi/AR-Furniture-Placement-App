import Foundation
import SwiftUI

struct FurnitureItem: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let description: String
    let usdzName: String       // Exact file name in bundle (case sensitive, no .usdz extension)
    let icon: String           // SF Symbol name
    let accentColor: Color
}

// Updated Catalog with 6 items total
let sampleItems: [FurnitureItem] = [
    // 1. The original chair
    FurnitureItem(
        name: "Modern Chair",
        description: "Minimal chair for living room or study.",
        usdzName: "Chair",  // Make sure this matches your file "Chair.usdz"
        icon: "chair.lounge.fill",
        accentColor: .teal
    ),
    
    // 2. Sofa
    FurnitureItem(
        name: "Velvet Sofa",
        description: "A comfortable three-seater sofa.",
        usdzName: "sofa",   // Expects "sofa.usdz"
        icon: "sofa.fill",
        accentColor: .indigo
    ),
    
    // 3. Coffee Table
    FurnitureItem(
        name: "Coffee Table",
        description: "Wooden table with a glass top.",
        usdzName: "table",  // Expects "table.usdz"
        icon: "table.furniture.fill",
        accentColor: .brown
    ),
    
    // 4. Floor Lamp
    FurnitureItem(
        name: "Floor Lamp",
        description: "Modern lighting for reading corners.",
        usdzName: "lamp",   // Expects "lamp.usdz"
        icon: "lamp.floor.fill",
        accentColor: .orange
    ),
    
    // 5. Flower Vase
    FurnitureItem(
        name: "Ceramic Vase",
        description: "Decorative vase with dried flowers.",
        usdzName: "vase",   // Expects "vase.usdz"
        icon: "vase", // Note: If this icon doesn't exist in older iOS, use "drop.fill"
        accentColor: .pink
    ),
    
    // 6. Indoor Plant
    FurnitureItem(
        name: "Ficus Plant",
        description: "Large indoor potted plant.",
        usdzName: "plant",  // Expects "plant.usdz"
        icon: "leaf.fill",
        accentColor: .green
    )
]
