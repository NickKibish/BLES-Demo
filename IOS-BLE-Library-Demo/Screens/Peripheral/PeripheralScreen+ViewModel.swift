//
//  PeripheralScreen+ViewModel.swift
//  IOS-BLE-Library-Demo
//
//  Created by Nick Kibysh on 29/09/2023.
//

import Foundation
import Combine

typealias PeripheralScreenEnvironment = PeripheralScreen.ViewModel.Environment

extension PeripheralScreen {
    class ViewModel: ObservableObject {
        lazy private (set) var environment = Environment(
            name: scanResult.name,
            connectionState: .disconnected,
            displayData: [],
            connectable: true, 
            connect: { [weak self] in self?.connect() },
            disconnect: { [weak self] in self?.disconnect() }
        )
        
        let scanResult: ScanResult
        private var cancelable = Set<AnyCancellable>()
        
        init(scanResult: ScanResult) {
            self.scanResult = scanResult
            
            self.environment = Environment(
                name: "My Device",
                connectionState: .disconnected,
                displayData: [
                    DisplayableTextValue(id: "1", description: "Man. data", value: Data([0x00, 0x01]))
                ],
                connectable: true,
                connect: { [weak self] in self?.connect() },
                disconnect: { [weak self] in self?.disconnect() }
            )
        }
    }
}

extension PeripheralScreen.ViewModel {
    func connect() {
        environment.connectionState = .connected
    }
    
    func disconnect() {
        environment.connectionState = .disconnected
    }
}

extension PeripheralScreen.ViewModel {
    class Environment: ObservableObject {
        @Published var name: String?
        @Published var connectionState: ConnectionState
        @Published var displayData: [DisplayableTextValue]
        @Published var connectable: Bool
        
        let connect: () -> ()
        let disconnect: () -> ()
        
        init(name: String?, connectionState: ConnectionState, displayData: [DisplayableTextValue], connectable: Bool, connect: @escaping () -> Void, disconnect: @escaping () -> Void) {
            self.name = name
            self.connectionState = connectionState
            self.displayData = displayData
            self.connectable = connectable
            self.connect = connect
            self.disconnect = disconnect
        }
    }
    
    enum ConnectionState {
        case connected, disconnected, connecting, disconnecting, error(Error)
    }
}
