//
//  ConnectionButton.swift
//  BLES-Demo
//
//  Created by Nick Kibysh on 26/09/2023.
//

import SwiftUI

struct ConnectionButton: View {
    enum ConnectionState {
        case connected, disconnected, connecting, disconnecting, error(Error)
    }
    
    let state: ConnectionState
    let connectable: Bool
    let connect: () -> ()
    let disconnect: () -> ()
    
    var body: some View {
        VStack {
            Button {
                if case .connected = state {
                    disconnect()
                } else {
                    connect()
                }
            } label: {
                Text(state.title)
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            .tint(state.color)
            .disabled(!state.isActive || !connectable)
            
            if case .error(let error) = state {
                Text(error.localizedDescription)
                    .foregroundStyle(.red)
                    .padding()
            }
            
        }
    }
}

private extension ConnectionButton.ConnectionState {
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
        ConnectionButton(state: .connected, connectable: true, connect: {}, disconnect: {})
        Divider()
        ConnectionButton(state: .disconnected, connectable: true, connect: {}, disconnect: {})
        Divider()
        ConnectionButton(state: .disconnected, connectable: false,connect: {}, disconnect: {})
        Divider()
        ConnectionButton(state: .connecting, connectable: true, connect: {}, disconnect: {})
        Divider()
        ConnectionButton(state: .disconnecting, connectable: true, connect: {}, disconnect: {})
        Divider()
        ConnectionButton(state: .error(E()), connectable: true, connect: {}, disconnect: {})
        Divider()
    }
}
