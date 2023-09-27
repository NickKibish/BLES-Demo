//
//  BluetoothStateBadge.swift
//  BLES-Demo
//
//  Created by Nick Kibysh on 20/09/2023.
//

import SwiftUI

struct BluetoothStateBadge: View {
    let state: BluetoothState
    
    var body: some View {
        Text(state.localizedDescription.uppercased())
            .font(.caption2)
            .foregroundStyle(.background)
            .padding(5)
            .frame(width: 120)
            .bluetoothState(state)
            .clipShape(Capsule())
    }
}

private extension BluetoothState {
    var color: Color {
        switch self {
        case .unknown:
            return .gray
        case .resetting:
            return .gray
        case .unsupported:
            return .red
        case .unauthorized:
            return .red
        case .poweredOff:
            return .red
        case .poweredOn:
            return .green
        }
    }
}

struct BluetoothStateColorModifier: ViewModifier {
    let state: BluetoothState
    
    func body(content: Content) -> some View {
        content.background(state.color.opacity(0.8))
    }
}

extension View {
    func bluetoothState(_ state: BluetoothState) -> some View {
        self.modifier(BluetoothStateColorModifier(state: state))
    }
}

#Preview {
    List {
        BluetoothStateBadge(state: .unknown)
        BluetoothStateBadge(state: .resetting)
        BluetoothStateBadge(state: .unsupported)
        BluetoothStateBadge(state: .unauthorized)
        BluetoothStateBadge(state: .poweredOff)
        BluetoothStateBadge(state: .poweredOn)
    }
}



