//
//  SignalLevelView.swift
//  BLES-Demo
//
//  Created by Nick Kibysh on 20/09/2023.
//

import SwiftUI

struct SignalLevelView: View {
    let signalLevel: ScanResult.SignalLevel
    
    var body: some View {
        Image(
            systemName: "cellularbars",
            variableValue: Double(4 - signalLevel.rawValue) / 5.0
        )
        .signalLevelColor(signalLevel: signalLevel)
    }
}

struct SignalLevelViewModifier: ViewModifier {
    let signalLevel: ScanResult.SignalLevel
    
    func body(content: Content) -> some View {
        switch signalLevel {
        case .excellent:
            content.foregroundStyle(.green)
        case .good:
            content.foregroundStyle(.yellow)
        case .ok:
            content.foregroundStyle(.orange)
        case .bad:
            content.foregroundStyle(.red)
        case .noSignal:
            content.foregroundStyle(.gray)
        }
    }
}

extension View {
    func signalLevelColor(signalLevel: ScanResult.SignalLevel) -> some View {
        self.modifier(SignalLevelViewModifier(signalLevel: signalLevel))
    }
}

#Preview {
    List {
        SignalLevelView(signalLevel: .excellent)
        SignalLevelView(signalLevel: .good)
        SignalLevelView(signalLevel: .ok)
        SignalLevelView(signalLevel: .bad)
        SignalLevelView(signalLevel: .noSignal)
    }
}
