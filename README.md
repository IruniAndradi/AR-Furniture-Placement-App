# AR Furniture Placement App

**ROOMARTIA2** is an iOS application built with Swift, ARKit, and RealityKit that allows users to visualize furniture in their real environment before purchasing. Users can place, move, rotate, and resize 3D furniture models in real-time using augmented reality.

---

## 📚 Table of Contents

1. [User Guide](#-user-guide)  
2. [Technical Documentation](#-technical-documentation)  
3. [Project Report](#-project-report)  
   - [Design Discussions](#design-discussions)  
   - [Development Challenges & Solutions](#development-challenges--solutions)  
   - [Testing Results](#testing-results)  
   - [Reflections](#reflections)  
4. [Installation](#-installation)

---

## 📖 User Guide

### 1. Exploring the Catalog
- Launch the app to open the **Home Screen**.  
- Tap **“Start with Catalog”** to browse the available furniture items.  
- Categories include Chairs, Sofas, Lamps, Plants, and more.

### 2. Placing Furniture in AR
- Select an item to open the **AR Camera View**.  
- **Scan the Floor** by moving your device side to side.  
- When a flat surface is detected, **tap the screen** to place the item.

### 3. Adjusting the Item
- **Move:** Drag with one finger.  
- **Rotate:** Twist with two fingers.  
- **Resize:** Pinch in/out to scale.

### 4. Saving Your Setup
- Enter a name for your layout (e.g., *“Bedroom Setup 1”*).  
- Tap **“Save Placement”** to store it.  
- View saved layouts from **Home → Saved Placements**.

---

## 🛠 Technical Documentation

### Technology Stack

| Component | Technology Used | Purpose |
|----------|------------------|---------|
| **Language** | Swift 5 | Core development |
| **UI Framework** | SwiftUI | Building UI components |
| **AR Engine** | ARKit + RealityKit | Plane detection, rendering, gestures |
| **Database** | CoreData | Storing user placements |
| **3D Model Format** | USDZ | Optimized for AR on Apple devices |

### System Architecture (MVVM)

- **Model**  
  - `FurnitureItem` – Static catalog item data  
  - `Placement` – CoreData entity for saved layouts  

- **View**  
  - `CatalogView` – Furniture browser  
  - `ARViewContainer` – Integrates ARView using `UIViewRepresentable`

- **ViewModel / Controller**  
  - `ARDataController` – CoreData and state management  

### Auto-Scaling Logic for Model Size

```swift
let bounds = modelEntity.visualBounds(relativeTo: nil)
let maxDimension = max(bounds.extents.x, max(bounds.extents.y, bounds.extents.z))
let targetSize: Float = 0.5
let scaleFactor = targetSize / maxDimension
modelEntity.scale = SIMD3<Float>(repeating: scaleFactor)
```

---

## 📝 Project Report

### Design Discussions

**UI/UX:**  
The app uses a clean iOS-native design with glassmorphism effects, subtle gradients, rounded cards, and unobtrusive overlays to keep the AR view clear.

**AR Experience:**  
- Raycasting with `.estimatedPlane` allows fast placement even with incomplete tracking.  
- Gestures (move, rotate, scale) provide real-world-like interaction.  

---

### Development Challenges & Solutions

#### 1. Inconsistent 3D Model Sizes  
Some assets imported extremely large or tiny due to different units.  
✔ **Solution:** Implemented an auto-scaling algorithm using `visualBounds`.

#### 2. Floating or Sinking Models  
Models often had pivot points in their center.  
✔ **Solution:** Enabled recursive collision shapes so RealityKit automatically aligns them to the detected plane.

#### 3. User Placement Confusion  
Users couldn't tell when tracking was ready.  
✔ **Solution:** Added Apple’s `ARCoachingOverlayView` for guidance.

---

### Testing Results

| Test Case | Scenario | Result | Status |
|----------|----------|--------|--------|
| Plane Detection | Carpet, tile, and wood floors | Detected in 2–3 seconds | ✅ Pass |
| Model Loading | “Modern Chair” asset | Correct scale, instant load | ✅ Pass |
| Gesture Controls | Rotate, scale, drag | Smooth interaction | ✅ Pass |
| Saving Layouts | Restart app after saving | Data persists | ✅ Pass |
| Low-Light Testing | Dim room | AR tracking unstable | ⚠️ Limitation |

---

### Reflections

- Bridging **SwiftUI with ARKit** required careful handling but resulted in clean, modular code.
- Model optimization was crucial—high-poly assets affect frame rate.
- Future features may include **LiDAR-based occlusion**, realistic shadows, and multi-object scenes.

---

## ⬇ Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/ROOMARTIA2.git
   ```
2. Open `ROOMARTIA2.xcodeproj` using **Xcode 15+**.  
3. Connect a real iPhone/iPad (ARKit is not supported in Simulator).  
4. Press **Cmd + R** to run the app.

---

*Developed by **Iruni Andradi***  
