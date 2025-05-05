//
//  Brick.swift
//  BrickWall
//
//  Created by Eric Jacobsen on 4/14/25.
//

public struct Brick {
    public let origin: BrickOrigin?
    public let size: BrickSize
    
    public init(
        columns: Int,
        rows: Int,
        x: Int? = nil,
        y: Int? = nil
    ) {
        self.size = BrickSize(columns: columns, rows: rows)
        if let x = x, let y = y {
            self.origin = .init(x: x, y: y)
        } else {
            self.origin = nil
        }
    }
    
    public init(origin: BrickOrigin, size: BrickSize) {
        self.origin = origin
        self.size = size
    }
    
    public init(size: BrickSize) {
        self.origin = nil
        self.size = size
    }
}

