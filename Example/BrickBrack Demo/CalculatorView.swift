//
//  CalculatorView.swift
//  BrickBrack Demo
//
//  Created by Eric Jacobsen on 4/14/25.
//

import SwiftUI
import BrickBrack

struct CalculatorView: View {
    @State private var orientation = UIDeviceOrientation.unknown
    
    var body: some View {
        return BrickBrack(gap:5, columns: orientation.isLandscape ? 6 : 4) {
            Text("MC")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    Brick(size: BrickSize(columns: 1, rows: 1))
                )
            
            Text("M+")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    Brick(size: BrickSize(columns: 1, rows: 1))
                )
            
            Text("/")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    Brick(size: BrickSize(columns: 1, rows: 1))
                )
            
            Text("x")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    Brick(size: BrickSize(columns: 1, rows: 1))
                )
            
            Text("7")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    Brick(size: BrickSize(columns: 1, rows: 1))
                )
            
            Text("8")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    Brick(size: BrickSize(columns: 1, rows: 1))
                )
            
            Text("9")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    Brick(size: BrickSize(columns: 1, rows: 1))
                )
            
            Text("-")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    Brick(size: BrickSize(columns: 1, rows: 1))
                )
            
            
            Text("6")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    Brick(size: BrickSize(columns: 1, rows: 1))
                )
            
            Text("5")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    Brick(size: BrickSize(columns: 1, rows: 1))
                )
            
            Text("4")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    Brick(size: BrickSize(columns: 1, rows: 1))
                )
            
            Text("+")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    Brick(size: BrickSize(columns: 1, rows: 1))
                )
            
            
            Text("1")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    Brick(size: BrickSize(columns: 1, rows: 1))
                )
            
            Text("2")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    Brick(size: BrickSize(columns: 1, rows: 1))
                )
            
            Text("3")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    Brick(size: BrickSize(columns: 1, rows: 1))
                )
            
            Text("=")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    Brick(size: BrickSize(columns: 1, rows: 2))
                )
            
            Text("0")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    Brick(size: BrickSize(columns: 2, rows: 1))
                )
            
            Text(".")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
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
    CalculatorView()
}
