//
//  ContentView.swift
//  AR Glasses
//
//  Created by Владимир Ладыгин on 22.03.2022.
//
import ARKit
import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func createCircle(x: Float = 0, y: Float = 0, z: Float = 0) -> Entity {
        //Create circle mesh
        let circle = MeshResource.generateBox(size: 0.05, cornerRadius: 0.025)
        
        //Create material
        let material = SimpleMaterial(color: .blue, isMetallic: true)
        
        //Create Entity
        let circleEntity = ModelEntity(mesh: circle, materials: [material])
        circleEntity.position = SIMD3(x, y, z)
        circleEntity.scale.x = 1.1
        circleEntity.scale.z = 0.01
        
        return circleEntity
        
    }
    func createBridge(x: Float = 0, y: Float = 0, z: Float = 0) -> Entity {
        //Create bridge mesh
        let bridge = MeshResource.generateBox(size: 0.005)
        
        //Create material
        let material = SimpleMaterial(color: .lightGray, isMetallic: true)
        
        //Create Entity
        let bridgeEntity = ModelEntity(mesh: bridge, materials: [material])
        bridgeEntity.position = SIMD3(x, y, z)
        bridgeEntity.scale.x = 5
        bridgeEntity.scale.z = 0.2
        
        return bridgeEntity
        
    }
    
    func makeUIView(context: Context) -> ARView {
        
        //Create AR view
        let arView = ARView(frame: .zero)
        
        //Check that face tracking configuration is suppirted
        guard ARFaceTrackingConfiguration.isSupported else {
            return arView
        }
        
        //create face tracking configuration
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        
        //Create face anchor
        let faceAnchor = AnchorEntity(.face)
        
        //Add box to the face ancor
        faceAnchor.addChild(createCircle(x: 0.035, y: 0.025, z: 0.06))
        faceAnchor.addChild(createCircle(x: -0.035, y: 0.025, z: 0.06))
        faceAnchor.addChild(createBridge(y: 0.035, z: 0.06))
        
        //run face tracking session
        arView.session.run(configuration, options: [])
        
        //add face anchor to the scene
        arView.scene.anchors.append(faceAnchor)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
