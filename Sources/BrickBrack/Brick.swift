//
//  Brick.swift
//  BrickBrack
//
//  Created by Eric Jacobsen on 4/14/25.
//

public struct Brick {
    public let origin: BrickOrigin?
    public let size: BrickSize
    
    public init(origin: BrickOrigin, size: BrickSize) {
        self.origin = origin
        self.size = size
    }
    
    public init(size: BrickSize) {
        self.origin = nil
        self.size = size
    }
}

