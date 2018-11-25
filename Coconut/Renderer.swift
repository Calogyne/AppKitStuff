//
//  Renderer.swift
//  Coconut
//
//  Created by Calogyne Chen on 2018/8/3.
//  Copyright © 2018 Calogyne Chen. All rights reserved.
//

import Foundation
import Metal
import QuartzCore

class Renderer {
    let device: MTLDevice = MTLCreateSystemDefaultDevice()!
    let cmdQueue: MTLCommandQueue
    let drawableSize: CGSize
    let renderPipelineState: MTLRenderPipelineState? = nil
    let timer: Timer? = nil
    let lst: List<Int>
    
    init(layer: CAMetalLayer) {
        self.cmdQueue = device.makeCommandQueue()!
        self.drawableSize = layer.drawableSize
        self.lst = .Con(5, .Nil)
        self.initializeDeviceResources()
    }
    
    func initializeDeviceResources() {
        let shader_lib = device.makeDefaultLibrary()
        let pipeline_descriptor = MTLRenderPipelineDescriptor()
        pipeline_descriptor.fragmentFunction = shader_lib?.makeFunction(name: "fragmentShader")
        pipeline_descriptor.vertexFunction = shader_lib?.makeFunction(name: "vertexShader")
    }
    
    func initializeSizeDependentResources() {
        
    }
}

enum List<T> {
    indirect case Con(T, List<T>)
    case Nil
}








