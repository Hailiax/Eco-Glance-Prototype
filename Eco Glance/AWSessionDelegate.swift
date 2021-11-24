//
//  AWSessionDelegate.swift
//  Eco Glance
//
//  Created by Alex Wing on 11/23/21.
//

import ARKit
import RealityKit

class AWSessionDelegate: NSObject, ARSessionDelegate {
    
    private var scene: RealityKit.Scene
    private var scores = [ARAnchor: AWScore]()
    
    init(_ rkScene: RealityKit.Scene) {
        scene = rkScene
    }
    
    // This is where we detect app clips
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if let anchor = anchor as? ARAppClipCodeAnchor {
                let score = AWScore(anchor)
                scene.anchors.append(score.anchor)
                scores[anchor] = score
            }
        }
    }
    
    // App clip anchor was removed
    func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
        for anchor in anchors {
            if let anchor = anchor as? ARAppClipCodeAnchor {
                scene.anchors.remove(scores[anchor]!.anchor)
                scores.removeValue(forKey: anchor)
            }
        }
    }
    
    // This can monitor the decoding/size of App Clip URLs
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        for anchor in anchors {
            if let anchor = anchor as? ARAppClipCodeAnchor {
                // Update the radius of the score
                scores[anchor]!.update(radius: anchor.radius)
                
                // Check the decoding of the App Clip. URL doesn't get decoded right now since our app clip isn't registered with Apple
//                if anchor.urlDecodingState != .decoding {
//                    let decodedURL: URL
//                    switch anchor.urlDecodingState {
//                    case .decoded:
//                        decodedURL = anchor.url!
//                        print("Successfully decoded ARAppClipCodeAnchor url: " + decodedURL.absoluteString)
//                    case .failed:
//                        print("Failed to decode app clip.")
//                        ()
//                    case .decoding:
//                        continue
//                    default:
//                        continue
//                    }
//                }
            }
        }
    }
    
}
