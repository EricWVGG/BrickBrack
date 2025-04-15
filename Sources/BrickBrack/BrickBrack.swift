//
//  BrickBrack.swift
//  BrickBrack
//
//  Created by Eric Jacobsen on 4/1/25.
//

// see README.md for usage

import SwiftUI

let ERROR_DOMAIN = "BrickBrackLayout"

struct BrickKey: @preconcurrency LayoutValueKey {
    @MainActor static var defaultValue: Brick = Brick(origin: BrickOrigin(x: 0, y: 0), size: BrickSize(columns: 1, rows: 1))
}

public struct BrickBrack: Layout {
    private let gapX: CGFloat
    private let gapY: CGFloat
    private let columns: Int
    
    public init(gapX: CGFloat, gapY: CGFloat, columns: Int) {
        self.gapX = gapX
        self.gapY = gapY
        self.columns = columns
    }
    
    public init(gap: CGFloat, columns: Int) {
        self.gapX = gap
        self.gapY = gap
        self.columns = columns
    }
    
    public struct Cache {
        var destinations: [CGRect] = []
        var bounds: CGRect = .zero
        var viewWidth: CGFloat = 0
    }
    
    public func makeCache(subviews: Subviews) -> Cache {
        return Cache()
    }
    
    public func updateCache(_ cache: inout Cache, subviews: Subviews) {
        cache.destinations = self.mapSubviewsToDestinations(
            subviews,
            cellSize: self.cellSize(forViewSize: cache.viewWidth), offset: CGPoint(
                x: max(cache.bounds.minX ?? 0, 0),
                y: max(cache.bounds.minY ?? 0, 0)
            )
        )
    }
    
     // # Required by Layout protocol
    public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) -> CGSize {
        cache.viewWidth = proposal.width ?? .infinity
        let y = self.mapSubviewsToDestinations(subviews, cellSize: self.cellSize(forViewSize: proposal.width ?? .infinity))
            .reduce(0) { maxY, destination in
                return max(maxY, destination.minY + destination.height)
            }
        return CGSize(width: proposal.width ?? .infinity, height: y ?? proposal.height ?? .infinity)
    }
    
    // # Required by Layout protocol
    public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) {
        if cache.bounds != bounds || subviews.count != cache.destinations.count {
            cache.bounds = bounds
            self.updateCache(&cache, subviews: subviews)
        }
        zip(subviews, cache.destinations).forEach { (subview, frame) in
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
    public func gridCell(_ brick: Brick) -> some View {
        layoutValue(key: BrickKey.self, value: brick)
    }
}

extension BrickBrack {
    private func cellSize(forViewSize viewSize: CGFloat) -> CGFloat {
        let cols = CGFloat(self.columns)
        return ( viewSize - self.gapX * (cols + 1) ) / cols
    }
}

extension BrickBrack {
    private func mapSubviewsToDestinations(
        _ subviews: Subviews,
        cellSize: CGFloat,
        offset: CGPoint = CGPoint(x: 0, y: 0)
    ) -> [CGRect] {
        let map = BrickBrackMap(columnCount: self.columns, subviews: subviews)

        return subviews.map { subview in
            let brick = subview[BrickKey.self]
            
            var originX: Int?
            var originY: Int?
            
            if let brickOrigin = subview[BrickKey.self].origin {
                originX = brickOrigin.x
                originY = brickOrigin.y
            } else {
                (originX, originY) = map.findOriginForUnmappedBrick(brick)
            }
            
            guard let originX = originX, let originY = originY else {
                #if DEBUG
                fatalError("Error finding origin for brick (this should be impossible).")
                #endif
            }
            return self.brickDestination(
                x: originX,
                y: originY,
                columns: brick.size.columns,
                rows: brick.size.rows,
                cellSize: cellSize,
                offset: offset
            )
        }
    }
    
    private func brickDestination(
        x originX: Int,
        y originY: Int,
        columns: Int,
        rows: Int,
        cellSize: CGFloat,
        offset: CGPoint
    ) -> CGRect {
        // Provides a CGRect for a given origin, and column/row set, and accounts for the grid gap and layout offset.

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
            x: offset.x + fOriginX * cellSize + xGapOffset,
            y: offset.y + fOriginY * cellSize + yGapOffset,
            width: fColumns * cellSize + xGapPad,
            height: fRows * cellSize + yGapPad
        )
    }
}

