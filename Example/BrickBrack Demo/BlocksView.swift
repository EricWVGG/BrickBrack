//
//  BlocksView.swift
//  BrickBrack Demo
//
//  Created by Eric Jacobsen on 4/14/25.
//

import SwiftUI
import BrickBrack

struct BlocksView: View {
    @State private var orientation = UIDeviceOrientation.unknown

    var body: some View {
        BrickBrack(gap:5, columns: orientation.isLandscape ? 9 : 5) {
            Text("1x2 at 0,0")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    Brick(origin: BrickOrigin( x: 0, y: 0 ), size: BrickSize(columns: 1, rows: 2))
                )
            
            Text("2x1 at 1,0")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.yellow)
                .gridCell(
                    Brick(origin: BrickOrigin( x: 1, y: 0 ), size: BrickSize(columns: 2, rows: 1))
                )

            Text("3x2, automatically placed")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.green)
                .gridCell(
                    // error: when origin is missing, this overlaps yellow brick.
                    // it appears that non-square "loosies" aren't positioning correctly.
                    Brick(size: BrickSize(columns: 3, rows: 2))
                )

            Text("2x1 auto")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.red)
                .gridCell(
                    Brick(size: BrickSize(columns: 1, rows: 3))
                )

            Text("1x1 auto")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.purple)
                .gridCell(
                    Brick(size: BrickSize(columns: 1, rows: 1))
                )

            Text("1x2 auto")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.pink)
                .gridCell(
                    Brick(size: BrickSize(columns: 1, rows: 2))
                )

            Text("1x1 auto")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.pink)
                .gridCell(
                    Brick(size: BrickSize(columns: 1, rows: 1))
                )

            Text("1x1 auto")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.indigo)
                .gridCell(
                    Brick(size: BrickSize(columns: 1, rows: 1))
                )

            Text("1x1 auto")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.mint)
                .gridCell(
                    Brick(size: BrickSize(columns: 1, rows: 1))
                )

            Text("5x2 auto")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.cyan)
                .gridCell(
                    Brick(size: BrickSize(columns: 5, rows: 1))
                )

            Text("1x1 auto")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.yellow)
                .gridCell(
                    Brick(size: BrickSize(columns: 1, rows: 1))
                )


        }
        .onRotate { newOrientation in
            orientation = newOrientation
        }
    }
}

#Preview {
    BlocksView()
}
