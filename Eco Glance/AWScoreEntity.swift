//
//  AWScoreEntity.swift
//  Eco Glance
//
//  Created by Alex Wing on 11/23/21.
//

import RealityKit

struct AWScoreEntity {
    
    func createScore() -> ModelEntity {
        return .init(mesh: .generateSphere(radius: 1),
                     materials: [UnlitMaterial(color: .init(hue: 0.304,
                                                            saturation: 1.0,
                                                            brightness: 0.8,
                                                            alpha: 0.0))])
    }
    
}
