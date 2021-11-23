//
//  ContentView.swift
//  Eco Glance
//
//  Created by Alex Wing on 11/22/21.
//

import SwiftUI
import ARKit
import RealityKit

// Need to retain a reference to session delegate. Ideally shouldn't be a global variable
var AWRetainSessionDelegate: ARSessionDelegate?

// Expose the scene to be mutated by the session delegate. Ideally shouldn't be a global variable
public var AWScene: RealityKit.Scene?

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
        AWRetainSessionDelegate = AWSessionDelegate()
        arView.session.delegate = AWRetainSessionDelegate
        
        // Save the scene
        AWScene = arView.scene
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}
