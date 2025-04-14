//
//  BrickBrack.swift
//  BrickBrack
//
//  Created by Eric Jacobsen on 4/1/25.
//

// see README.md for usage

import SwiftUI

let ERROR_DOMAIN = "BrickBrackLayout"

struct BrickOrigin {
    let x: Int
    let y: Int
}

struct BrickSize {
    let columns: Int
    let rows: Int
}

struct Brick {
    let origin: BrickOrigin?
    let size: BrickSize
}

struct BrickKey: LayoutValueKey {
    static var defaultValue: Brick = Brick(origin: BrickOrigin(x: 0, y: 0), size: BrickSize(columns: 1, rows: 1))
}

struct BrickBrack: Layout {
    private let gapX: CGFloat
    private let gapY: CGFloat
    private let columnCount: Int
    
    public init(gapX: CGFloat, gapY: CGFloat, columnCount: Int) {
        self.gapX = gapX
        self.gapY = gapY
        self.columnCount = columnCount
    }
    
    public init(gap: CGFloat, columnCount: Int) {
        self.gapX = gap
        self.gapY = gap
        self.columnCount = columnCount
    }
    
    // # Required by Layout protocol
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        // Returns the size of the content in the Grid.

        let cellSize = self.cellSize(forGridSize:proposal.width ?? 1000)
        
        // Cycle through every brick for the lowest y and add that brick's height
        let y = subviews.reduce(0) {
            let brick = $1[BrickKey.self]
            let fromTop = CGFloat(integerLiteral: brick.origin?.y ?? 0)
            let yGapOffset = (fromTop + 1) * self.gapY
            
            let rows = CGFloat(integerLiteral: brick.size.rows)
            let yGapPad: CGFloat = (rows - 1) * self.gapY
            
            let heightOfBrick = rows * cellSize + yGapPad
            let yOffset = fromTop * cellSize + yGapOffset
            
            return max($0, yOffset + heightOfBrick)
        }
        
        return CGSize(width: proposal.width ?? .infinity, height: y)
    }
    
    // # Required by Layout protocol
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        // Places views inside the grid.
        var destinations: [CGRect] = []
        
        let BrickBrackMap = BrickBrackMap(columnCount: self.columnCount, subviews: subviews)
        
        subviews.forEach { subview in
            let brick = subview[BrickKey.self]
            
            var originX: Int?
            var originY: Int?
            
            if let brickOrigin = subview[BrickKey.self].origin {
                originX = brickOrigin.x
                originY = brickOrigin.y
            } else {
                (originX, originY) = BrickBrackMap.originForUnmappedBrick(brick)
            }
            
            guard let originX = originX, let originY = originY else {
                #if DEBUG
                fatalError("Error finding origin for brick (this should be impossible).")
                #endif
            }
            let destination = self.brickDestination(x: originX, y: originY, columns: brick.size.columns, rows: brick.size.rows, withinBounds: bounds)
            destinations.append(destination)
        }
        
        zip(subviews, destinations).forEach { (subview, frame) in
            return subview.place(
                at: frame.origin,
                anchor: .topLeading,
                proposal: ProposedViewSize(width: frame.size.width, height: frame.size.height)
            )
        }
    }
}

extension View {
    // This adds a .gridCell() modifier to SwiftUI views, so we can feed desired brick dimensions to the layout.
    func gridCell(_ brick: Brick) -> some View {
        layoutValue(key: BrickKey.self, value: brick)
    }
}

extension BrickBrack {
    private func cellSize(forGridSize gridSize: CGFloat) -> CGFloat {
        let cols = CGFloat(self.columnCount)
        return ( gridSize - self.gapX * (cols + 1) ) / cols
    }
}

extension BrickBrack {
    func brickDestination(x originX: Int, y originY: Int, columns: Int, rows: Int, withinBounds bounds: CGRect) -> CGRect {
        // Provides a CGRect for a given origin, and column/row set, and accounts for the grid gap.

        // a Swift Layout might not start at 0,0; this is the actual origin of the layout.
        let minX = max(bounds.minX, 0)
        let minY = max(bounds.minY, 0)
        
        let cellSize = self.cellSize(forGridSize: bounds.size.width)

        // convert values to floats
        let fOriginX: CGFloat = CGFloat(originX)
        let fOriginY: CGFloat = CGFloat(originY)
        let fColumns = CGFloat(columns)
        let fRows = CGFloat(rows)
        
        // When a grid has a gap, we have to account for the offset for the cell caused by the gap.
        // todo: Is view using the gap value for padding? Those are different things.
        let xGapOffset = (fOriginX + 1) * self.gapX
        let yGapOffset = (fOriginY + 1) * self.gapY
        
        // When a grid has a gap, we have to add the space between the cells to get its actual width.
        let xGapPad = (fColumns - 1) * self.gapX
        let yGapPad = (fRows - 1) * self.gapY
        
        return CGRect(
            x: minX + fOriginX * cellSize + xGapOffset,
            y: minY + fOriginY * cellSize + yGapOffset,
            width: fColumns * cellSize + xGapPad,
            height: fRows * cellSize + yGapPad
        )
    }
}

