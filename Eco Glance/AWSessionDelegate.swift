//
//  AWSessionDelegate.swift
//  Eco Glance
//
//  Created by Alex Wing on 11/23/21.
//

import ARKit
import RealityKit

class AWSessionDelegate: NSObject, ARSessionDelegate {
    
    // This is where we detect app clips. Since we cannot decode URLs right now, sustainability scores are assigned randomly.
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if let anchor = anchor as? ARAppClipCodeAnchor {
                let anchorEntity = AnchorEntity(anchor: anchor)
                let score = AWScoreEntity().createScore(radius: anchor.radius)
                anchorEntity.addChild(score)
                AWScene!.anchors.append(anchorEntity)
            }
        }
    }
    
    // This can monitor the decoding of App Clip URLs. Doesn't work right now since we haven't registered the app clip.
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        for anchor in anchors {
            if let appClipCodeAnchor = anchor as? ARAppClipCodeAnchor, appClipCodeAnchor.urlDecodingState != .decoding {
                let decodedURL: URL
                switch appClipCodeAnchor.urlDecodingState {
                case .decoded:
                    decodedURL = appClipCodeAnchor.url!
//                    print("Successfully decoded ARAppClipCodeAnchor url: " + decodedURL.absoluteString)
                case .failed:
//                    print("Failed to decode app clip.")
                    ()
                case .decoding:
                    continue
                default:
                    continue
                }
            }
        }
    }
    
}
