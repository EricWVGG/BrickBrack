//
//  CalculatorView.swift
//  BrickBrack Demo
//
//  Created by Eric Jacobsen on 4/14/25.
//

import SwiftUI
import BrickBrack

// todo: this is kinda messed up and needs debugging

func BrickMap(_ identifier: String, _ orientation: UIDeviceOrientation) -> Brick {
    switch identifier {
        case "0": !orientation.isLandscape
            ? Brick(size: BrickSize(columns: 2, rows: 1))
            : Brick(origin: BrickOrigin(x: 0, y: 3), size: BrickSize(columns: 2, rows: 1))
        case "1": !orientation.isLandscape
            ? Brick(size: BrickSize(columns: 1, rows: 1))
            : Brick(origin: BrickOrigin(x: 0, y: 0), size: BrickSize(columns: 1, rows: 1))
        case "2": !orientation.isLandscape
            ? Brick(size: BrickSize(columns: 1, rows: 1))
            : Brick(origin: BrickOrigin(x: 0, y: 1), size: BrickSize(columns: 1, rows: 1))
        case "3": !orientation.isLandscape
            ? Brick(size: BrickSize(columns: 1, rows: 1))
            : Brick(origin: BrickOrigin(x: 0, y: 2), size: BrickSize(columns: 1, rows: 1))
        case "4": !orientation.isLandscape
            ? Brick(size: BrickSize(columns: 1, rows: 1))
            : Brick(origin: BrickOrigin(x: 1, y: 0), size: BrickSize(columns: 1, rows: 1))
        case "5": !orientation.isLandscape
            ? Brick(size: BrickSize(columns: 1, rows: 1))
            : Brick(origin: BrickOrigin(x: 1, y: 1), size: BrickSize(columns: 1, rows: 1))
        case "6": !orientation.isLandscape
            ? Brick(size: BrickSize(columns: 1, rows: 1))
            : Brick(origin: BrickOrigin(x: 1, y: 2), size: BrickSize(columns: 1, rows: 1))
        case "7": !orientation.isLandscape
            ? Brick(size: BrickSize(columns: 1, rows: 1))
            : Brick(origin: BrickOrigin(x: 2, y: 0), size: BrickSize(columns: 1, rows: 1))
        case "8": !orientation.isLandscape
            ? Brick(size: BrickSize(columns: 1, rows: 1))
            : Brick(origin: BrickOrigin(x: 2, y: 1), size: BrickSize(columns: 1, rows: 1))
        case "9": !orientation.isLandscape
            ? Brick(size: BrickSize(columns: 1, rows: 1))
            : Brick(origin: BrickOrigin(x: 2, y: 2), size: BrickSize(columns: 1, rows: 1))
            
        case ".": !orientation.isLandscape
            ? Brick(size: BrickSize(columns: 1, rows: 1))
            : Brick(origin: BrickOrigin(x: 2, y: 3), size: BrickSize(columns: 1, rows: 1))
            
        case "/": !orientation.isLandscape
            ? Brick(size: BrickSize(columns: 1, rows: 1))
            : Brick(origin: BrickOrigin(x: 3, y: 1), size: BrickSize(columns: 1, rows: 1))
        case "*": !orientation.isLandscape
            ? Brick(size: BrickSize(columns: 1, rows: 1))
            : Brick(origin: BrickOrigin(x: 3, y: 0), size: BrickSize(columns: 1, rows: 1))
        case "-": !orientation.isLandscape
            ? Brick(size: BrickSize(columns: 1, rows: 1))
            : Brick(origin: BrickOrigin(x: 3, y: 2), size: BrickSize(columns: 1, rows: 1))
        case "+": !orientation.isLandscape
            ? Brick(size: BrickSize(columns: 1, rows: 1))
            : Brick(origin: BrickOrigin(x: 3, y: 3), size: BrickSize(columns: 1, rows: 1))
        case "=": !orientation.isLandscape
            ? Brick(size: BrickSize(columns: 2, rows: 1))
            : Brick(origin: BrickOrigin(x: 4, y: 2), size: BrickSize(columns: 1, rows: 2))
        case "MC": !orientation.isLandscape
            ? Brick(size: BrickSize(columns: 1, rows: 1))
            : Brick(origin: BrickOrigin(x: 4, y: 0), size: BrickSize(columns: 1, rows: 1))
        case "M+": !orientation.isLandscape
            ? Brick(size: BrickSize(columns: 1, rows: 1))
            : Brick(origin: BrickOrigin(x: 4, y: 1), size: BrickSize(columns: 1, rows: 1))
            
        default:
            Brick(size: BrickSize(columns: 1, rows: 1))
    }
}

struct CalculatorView: View {
    @State private var orientation = UIDeviceOrientation.unknown
    
    var body: some View {
        return BrickBrack(gap:5, columns: orientation.isLandscape ? 5 : 4) {
            Text("0")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    BrickMap("0", orientation)
                )
            
            Text("1")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    BrickMap("1", orientation)
                )
            
            Text("2")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    BrickMap("2", orientation)
                )
            
            Text("3")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    BrickMap("3", orientation)
                )
            
            
            Text("4")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    BrickMap("4", orientation)
                )
            
            Text("5")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    BrickMap("5", orientation)
                )
            
            Text("6")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    BrickMap("6", orientation)
                )
            
            Text("7")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    BrickMap("7", orientation)
                )
            
            Text("8")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    BrickMap("8", orientation)
                )
            
            Text("9")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    BrickMap("9", orientation)
                )
            
            Text(".")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    BrickMap(".", orientation)
                )
            
            Text("-")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    BrickMap("-", orientation)
                )
            
            Text("+")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    BrickMap("+", orientation)
                )
            
            Text("/")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    BrickMap("/", orientation)
                )
            
            Text("*")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    BrickMap("x", orientation)
                )
            
            Text("=")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    BrickMap("=", orientation)
                )
            
            Text("MC")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    BrickMap("MC", orientation)
                )
            
            Text("M+")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue)
                .gridCell(
                    BrickMap("M+", orientation)
                )
            
        }
        .frame(maxWidth: orientation.isLandscape ? 350 : .infinity)
        .onRotate { newOrientation in
            orientation = newOrientation
        }
    }
}

#Preview {
    CalculatorView()
}
