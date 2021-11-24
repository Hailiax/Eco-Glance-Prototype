//
//  AWScoreEntity.swift
//  Eco Glance
//
//  Created by Alex Wing on 11/23/21.
//

import ARKit
import RealityKit

struct AWScore {
    
    public var anchor: AnchorEntity
    private var entity: ModelEntity
    
    init(_ arAnchor: ARAnchor) {
        entity = .init(mesh: .generateSphere(radius: 1),
                       materials: [UnlitMaterial(color: .init(hue: 0.304,
                                                              saturation: 1.0,
                                                              brightness: 0.8,
                                                              alpha: 0.0))])
        anchor = AnchorEntity(anchor: arAnchor)
        anchor.addChild(entity)
    }
    
    func update(radius: Float) {
        entity.scale = simd_make_float3(radius, radius, radius)
        var component = entity.components[ModelComponent.self]!.self as! ModelComponent
        component.materials = [UnlitMaterial(color: .init(hue: 0.304,
                                                          saturation: .init((radius - 0.02) / 0.02),
                                                          brightness: 0.8,
                                                          alpha: 1.0))]
        entity.components.set(component)
    }
    
}
