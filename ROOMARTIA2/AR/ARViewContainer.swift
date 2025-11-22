import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    let item: FurnitureItem

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)

        // 1. Configure Plane Detection
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        config.environmentTexturing = .automatic
        arView.session.run(config)

        // 2. Add Coached Overlay (Helps you find the floor)
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = arView.session
        coachingOverlay.goal = .horizontalPlane
        arView.addSubview(coachingOverlay)

        // 3. Setup Tap Gesture
        let tapGesture = UITapGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handleTap(_:))
        )
        arView.addGestureRecognizer(tapGesture)

        context.coordinator.arView = arView
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(item: item)
    }

    class Coordinator: NSObject {
        let item: FurnitureItem
        weak var arView: ARView?

        init(item: FurnitureItem) {
            self.item = item
        }

        @objc func handleTap(_ gesture: UITapGestureRecognizer) {
            guard let arView = arView else { return }
            let location = gesture.location(in: arView)

            // Raycast to find the floor
            let results = arView.raycast(
                from: location,
                allowing: .estimatedPlane,
                alignment: .horizontal
            )

            if let result = results.first {
                let anchor = AnchorEntity(world: result.worldTransform)

                do {
                    // Load the model
                    let modelEntity = try ModelEntity.loadModel(named: item.usdzName)
                    
                    // --- NEW AUTO-SCALING LOGIC START ---
                    
                    // 1. Get the natural bounds of the model (how big is it really?)
                    let bounds = modelEntity.visualBounds(relativeTo: nil)
                    let size = bounds.extents // width, height, depth
                    
                    // Print the size to the console for debugging
                    print("Original Model Size: \(size)")
                    
                    // 2. Find the largest dimension (e.g., height or width)
                    let maxDimension = max(size.x, max(size.y, size.z))
                    
                    // 3. Decide how big you want it to be in Real Life (e.g., 0.5 meters)
                    let targetSize: Float = 0.003
                    
                    // 4. Calculate the scale factor
                    // If model is 1000m, scale will be 0.5/1000 = 0.0005
                    // If model is 1m, scale will be 0.5/1 = 0.5
                    let scaleFactor = targetSize / maxDimension
                    
                    modelEntity.scale = SIMD3<Float>(repeating: scaleFactor)
                    
                    // --- NEW AUTO-SCALING LOGIC END ---

                    // Add collision for gestures
                    modelEntity.generateCollisionShapes(recursive: true)
                    
                    // Enable gestures (Pinch to resize, Drag to move)
                    arView.installGestures([.translation, .rotation, .scale], for: modelEntity)

                    anchor.addChild(modelEntity)
                    arView.scene.addAnchor(anchor)
                    
                } catch {
                    print("Failed to load model: \(error)")
                }
            }
        }
    }
}
