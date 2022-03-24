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
        
        
        //run face tracking session
        arView.session.run(configuration, options: [])
        
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
