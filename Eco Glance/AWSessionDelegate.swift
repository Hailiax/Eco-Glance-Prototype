//
//  AWSessionDelegate.swift
//  Eco Glance
//
//  Created by Alex Wing on 11/23/21.
//

import ARKit
import RealityKit

class AWSessionDelegate: NSObject, ARSessionDelegate {
    
    var scores = [ARAnchor: (ModelEntity, AnchorEntity)]()
    
    // This is where we detect app clips. Since we cannot decode URLs right now, sustainability scores are assigned randomly.
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if let anchor = anchor as? ARAppClipCodeAnchor {
                let anchorEntity = AnchorEntity(anchor: anchor)
                let score = AWScoreEntity().createScore()
                anchorEntity.addChild(score)
                AWScene!.anchors.append(anchorEntity)
                scores[anchor] = (score, anchorEntity)
            }
        }
    }
    
    // App clip anchor was removed
    func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
        for anchor in anchors {
            if let anchor = anchor as? ARAppClipCodeAnchor {
                let (_, anchorEntity) = scores[anchor]!
                AWScene!.anchors.remove(anchorEntity)
                scores.removeValue(forKey: anchor)
            }
        }
    }
    
    // This can monitor the decoding/size of App Clip URLs
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        for anchor in anchors {
            if let anchor = anchor as? ARAppClipCodeAnchor {
                // Update the radius of the score
                let radius = anchor.radius
                let (score, _) = scores[anchor]!
                score.scale = simd_make_float3(radius, radius, radius)
                var component = score.components[ModelComponent.self]!.self as! ModelComponent
                component.materials = [UnlitMaterial(color: .init(hue: 0.304,
                                                                  saturation: .init((radius - 0.02) / 0.02),
                                                                  brightness: 0.8,
                                                                  alpha: 1.0))]
                score.components.set(component)
                
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
