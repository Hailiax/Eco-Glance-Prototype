//
//  ContentView.swift
//  Eco Glance
//
//  Created by Alex Wing on 11/22/21.
//

import SwiftUI
import ARKit
import RealityKit

// Need to retain a reference to session delegate.
fileprivate var AWRetainSessionDelegate: ARSessionDelegate?

struct ContentView : View {
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        // Check for app clip tracking support (needs Apple Neural Engine)
        if !ARWorldTrackingConfiguration.supportsAppClipCodeTracking {
            print("ERROR: App clip tracking not supported")
        }
        
        // Create our AR View
        let arView = ARView(frame: .zero)
        
        // Enable app clip tracking
        arView.automaticallyConfigureSession = false
        let newConfiguration = ARWorldTrackingConfiguration()
        newConfiguration.appClipCodeTrackingEnabled = true
        arView.session.run(newConfiguration)
        
        // Set our session delegate for app clip processing
        AWRetainSessionDelegate = AWSessionDelegate(arView.scene)
        arView.session.delegate = AWRetainSessionDelegate
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}
