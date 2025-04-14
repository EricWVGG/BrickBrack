//
//  Map.swift
//  BrickBrack
//
//  Created by Eric Jacobsen on 4/1/25.
//

/*
 The map is a simple one-dimensional array of integers that represent each cell in the grid that makes up a wall.
 It is not used for placement, just to indicate where available spaces are.
 
 ex. A four column grid that has a 2x1 brick at origin 0,0, and a 1x2 brick at origin 4,8. The grid looks like this…
   X X _ X
   _ _ _ X
 … results in a map of [0, 1, 3, 7]
 
 When a new brick is added, it loops over its template and tests for available cells from each possible origin.
 That's very easy for horizontal bricks. A 2x1 brick…
  X X _ _
 … results in a template of [0, 1]. A 3x1 is [0,1,2], etc.
    2x1 brick, origin 1: [0,1].forEach { return !map.contains(0+offset) && !map.contains(1+offset) } // fails above map; 1 is occupied.
    2x1 brick, origin 4: [0,1].forEach { return !map.contains(0+offset && !map.contains(1+offset) } // succeeds; [4,5] in the map are available.
 
 Vertical bricks are slightly more complicated; each cell needs the column count added to it.
 Ex. a 3x1
    X _ _ _
    X _ _ _
    X _ _ _
 … so this brick’s template is [0,4,8]
    1x3 brick, origin 0: [0,4,8].forEach { return !map.contains(0+offset) && !map.contains(4+offset) && !map.contains(8+offset) } // fails; 0 is occupied.
    1x3 brick, origin 2: [0,4,8].forEach { return !map.contains(0+offset) && !map.contains(4+offset) && !map.contains(8+offset) } // succeeds; [2,6,10] are available.
 */

extension BrickBrack {
    class BrickBrackMap {
        public var cells: [Int] = []
        public let columnCount: Int
        
        init(columnCount: Int, subviews: Subviews? = nil) {
            self.columnCount = columnCount
            if let subviews = subviews {
                self.fillCellsFromSubviews(subviews)
            }
        }
        
        func fillCellsFromSubviews(_ subviews: Subviews) {
            subviews.forEach { subview in
                let brick = subview[BrickKey.self]
                if let origin = brick.origin {
                    let originCell = origin.y * self.columnCount + origin.x
                    let brickTemplate = brickTemplate(for: brick, atOffset: originCell)
                    brickTemplate.forEach { cell in
                        self.cells.append(cell)
                    }
                }
            }
        }
        
        func brickTemplate(for brick: Brick, atOffset offset: Int = 0) -> [Int] {
            // Returns an array of cells that a brick would fill.
            // ex. 3x1 brick at offset 0 returns [0, 1, 2]
            var occupiedCells: [Int] = []
            do {
                try (0..<brick.size.rows).forEach { y in
                    try (0..<brick.size.columns).forEach { x in
                        guard x / (self.columnCount - 1) <= 1 else {
                            // todo: test that this is firing correctly
                            throw NSError(domain: ERROR_DOMAIN, code: 0, userInfo: [NSLocalizedDescriptionKey: "Brick exceeds column width."])
                        }
                        occupiedCells.append(y * self.columnCount + x + offset)
                    }
                }
            } catch {
                print("\(ERROR_DOMAIN) error:", error.localizedDescription)
            }
            return occupiedCells
        }
        
        func coordinatesForCell(_ cell: Int) -> (Int, Int) {
            /* Returns x/y coordinates of any cell.
                ex. in a 4-column grid…
                    0 1 2 3
                    4 5 6 7…
                cell 4 is at x: 0, y: 1
             */
            let originY = Int(floor(Double(cell) / Double(self.columnCount)))
            let originX = cell - (originY * self.columnCount)
            return (originX, originY)
        }
        
        func originForUnmappedBrick(_ brick: Brick) -> (Int, Int) {
            // For each possible origin, see if brick's template is occupied.
            
            // If max occupied cell is 42, check everything up to that, and add an empty row in case everything is occupied to that point.
            let cellsToCheck = (self.cells.max() ?? 0) + self.columnCount
            
            let originCell: Int? = (0..<cellsToCheck).enumerated().reduce(nil) { (currentResult, current) in
                if currentResult != nil {
                    // we already have a valid origin
                    return currentResult
                }
                let possibleOrigin = current.0
                let templateAtThisOrigin = self.brickTemplate(for: brick, atOffset: possibleOrigin)
                let valid = templateAtThisOrigin.reduce(true) { valid, cell in
                    return !valid || !self.cells.contains(cell)
                }
                return valid ? possibleOrigin : nil
            }
            
            guard let originCell = originCell else {
                #if DEBUG
                fatalError("Could not find origin for brick. (This should be impossible, there is no upper limit on map.)")
                #endif
            }
            
            // fill in the map
            let cellsAtThisOrigin = self.brickTemplate(for: brick, atOffset: originCell)
            cellsAtThisOrigin.forEach { self.cells.append($0) }
            
            return self.coordinatesForCell(originCell)
        }
    }
}
