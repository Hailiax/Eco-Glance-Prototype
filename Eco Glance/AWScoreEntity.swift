//
//  AWScoreEntity.swift
//  Eco Glance
//
//  Created by Alex Wing on 11/23/21.
//

import RealityKit

struct AWScoreEntity {
    
    func createScore(radius: Float) -> ModelEntity {
        print(radius)
        return .init(mesh: .generateSphere(radius: radius),
                     materials: [SimpleMaterial(color: .init(hue: 0.304,
                                                             saturation: .init((radius - 0.04)/0.07),
                                                             brightness: 0.8,
                                                             alpha: 1.0),
                                                roughness: 1.0,
                                                isMetallic: false)])
    }
    
}
