//
//  BrickBrack_DemoApp.swift
//  BrickBrack Demo
//
//  Created by Eric Jacobsen on 4/14/25.
//

import SwiftUI

@main
struct BrickBrack_DemoApp: App {
    enum Screen {
        case blocks, calculator
    }
    
    @State private var currentScreen: Screen = .blocks
    
    var body: some Scene {
        WindowGroup {
            VStack {
                Picker("Screen", selection: $currentScreen) {
                    Text("Basic blocks demo").tag(Screen.blocks)
                    Text("Calculator demo").tag(Screen.calculator)
                }
                .pickerStyle(.segmented)
                
                VStack {
                    switch currentScreen {
                        case .blocks:
                            BlocksView()
                        case .calculator:
                            CalculatorView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}
