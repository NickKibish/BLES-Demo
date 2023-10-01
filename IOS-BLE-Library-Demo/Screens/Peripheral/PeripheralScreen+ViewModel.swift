//
//  PeripheralScreen+ViewModel.swift
//  IOS-BLE-Library-Demo
//
//  Created by Nick Kibysh on 29/09/2023.
//

import Foundation
import Combine
import iOS_BLE_Library

typealias PeripheralScreenEnvironment = PeripheralScreen.ViewModel.Environment

extension PeripheralScreen {
    class ViewModel: ObservableObject {
        lazy private (set) var environment = Environment(
            name: scanResult.name,
            connectionState: .disconnected,
            displayData: mapAdvertisementData(scanResult.advertisementData),
            rssi: DisplayableRSSI(rssi: -200),
            connectable: true,
            connect: { [weak self] in self?.connect() },
            disconnect: { [weak self] in self?.disconnect() }
        )
        
        let scanResult: ScanResult
        private var cancelable = Set<AnyCancellable>()
        
        let centralManager: CentralManager
        
        init(scanResult: ScanResult, centralManager: CentralManager) {
            self.scanResult = scanResult
            self.centralManager = centralManager
        }
    }
}

extension PeripheralScreen.ViewModel {
    func connect() {
        guard let peripheral = centralManager.retrievePeripherals(withIdentifiers: [scanResult.id]).first else {
            return
        }
        environment.connectionState = .connecting
        
        centralManager.connect(peripheral)
            .autoconnect()
            .sink { completion in
                switch completion {
                case .finished:
                    self.environment.connectionState = .disconnected
                case .failure(let e):
                    self.environment.connectionState = .error(e)
                }
            } receiveValue: { _ in
                self.environment.connectionState = .connected
            }
            .store(in: &cancelable)

    }
    
    func disconnect() {
        guard let peripheral = centralManager.retrievePeripherals(withIdentifiers: [scanResult.id]).first else {
            return
        }
        environment.connectionState = .disconnecting
        
        Task {
            _ = try await centralManager.cancelPeripheralConnection(peripheral)
                .autoconnect()
                .value
        }
        

    }
}

extension PeripheralScreen.ViewModel {
    class Environment: ObservableObject {
        @Published var name: String?
        @Published var connectionState: ConnectionState
        @Published var displayData: [DisplayableValue]
        @Published var rssi: DisplayableRSSI
        @Published var connectable: Bool
        
        let connect: () -> ()
        let disconnect: () -> ()
        
        init(name: String?, connectionState: ConnectionState, displayData: [DisplayableValue], rssi: DisplayableRSSI, connectable: Bool, connect: @escaping () -> Void, disconnect: @escaping () -> Void) {
            self.name = name
            self.connectionState = connectionState
            self.displayData = displayData
            self.rssi = rssi
            self.connectable = connectable
            self.connect = connect
            self.disconnect = disconnect
        }
    }
    
    enum ConnectionState {
        case connected, disconnected, connecting, disconnecting, error(Error)
    }
}
