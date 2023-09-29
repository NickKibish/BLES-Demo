//
//  ConnectionButton.swift
//  BLES-Demo
//
//  Created by Nick Kibysh on 26/09/2023.
//

import SwiftUI

struct ConnectionButton: View {
    @EnvironmentObject var peripheralEnv: PeripheralScreenEnvironment
    
    var body: some View {
        VStack {
            Button {
                if case .connected = peripheralEnv.connectionState {
                    peripheralEnv.disconnect()
                } else {
                    peripheralEnv.connect()
                }
            } label: {
                Text(peripheralEnv.connectionState.title)
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            .tint(peripheralEnv.connectionState.color)
            .disabled(!peripheralEnv.connectionState.isActive || !peripheralEnv.connectable)
            
            if case .error(let error) = peripheralEnv.connectionState {
                Text(error.localizedDescription)
                    .foregroundStyle(.red)
                    .padding()
            }
            
        }
    }
}

private extension PeripheralScreen.ViewModel.ConnectionState {
    var title: String {
       switch self {
         case .connected:
              return "Disconnect"
            case .disconnected:
                return "Connect"
            case .connecting:
                return "Connecting..."
            case .disconnecting:
                return "Disconnecting..."
            case .error:
                return "Retry"
       }
    }

    var color: Color {
        switch self {
        case .connected:
            return .red
        case .disconnected:
            return .blue
        case .connecting:
            return .yellow
        case .disconnecting:
            return .yellow
        case .error:
            return .orange
        }
    }
    
    var isActive: Bool {
        switch self {
        case .connected, .disconnected, .error:
            return true
        case .connecting, .disconnecting:
            return false
        }
    }
}

private struct E: Error {
    
}

#Preview {
    VStack {
        ConnectionButton()
            .environmentObject(PeripheralScreenEnvironment())
    }
}
