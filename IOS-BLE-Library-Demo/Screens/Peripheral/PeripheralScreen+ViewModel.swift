//
//  PeripheralScreen+ViewModel.swift
//  IOS-BLE-Library-Demo
//
//  Created by Nick Kibysh on 29/09/2023.
//

import Foundation
import Combine
// 3.1 - Import Library
import iOS_BLE_Library

typealias PeripheralScreenEnvironment = PeripheralScreen.ViewModel.Environment

extension PeripheralScreen {
    class ViewModel: ObservableObject {
        lazy private (set) var environment = Environment(
            name: scanResult.name,
            connectionState: .disconnected,
            displayData: mapAdvertisementData(scanResult.advertisementData),
            rssi: DisplayableRSSI(rssi: scanResult.rssi),
            connectable: true,
            connect: { [weak self] in self?.connect() },
            disconnect: { [weak self] in self?.disconnect() },
            startTrackingChanges: { [weak self] in self?.startTrackingChanges() },
            stopTrackingChanges: { [weak self] in self?.stopTrackingChanges() }
        )
        
        let scanResult: ScanResult
        private var cancelable = Set<AnyCancellable>()
        // 3.2 - Create CentralManager Instance
        let centralManager: CentralManager
        
        // 3.3 - Add centralManager as a parameter to init
        init(scanResult: ScanResult, centralManager: CentralManager) {
            self.scanResult = scanResult
            
            // 3.4 - Assign `CentralManager`
            self.centralManager = centralManager
        }
    }
}

extension PeripheralScreen.ViewModel {
    func connect() {
        // 4.3 - Retreive peripheral
        guard let peripheral = centralManager.retrievePeripherals(withIdentifiers: [scanResult.id]).first else {
            return
        }
        
        // 4.1 - Change state to `connecting`
        environment.connectionState = .connecting
        
        // 4.4 - Connect peripheral
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
        // 4.5 Retreive the peripheral
        guard let peripheral = centralManager.retrievePeripherals(withIdentifiers: [scanResult.id]).first else {
            return
        }
        
        // 4.2 - Change state to `disconnecting`
        environment.connectionState = .disconnecting
        
        // 4.6 Disconnect the peripheral
        Task {
            _ = try await centralManager.cancelPeripheralConnection(peripheral)
                .autoconnect()
                .value
        }
    }
}

extension PeripheralScreen.ViewModel {
    func startTrackingChanges() { }
    func stopTrackingChanges() { }
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
        let startTrackingChanges: () -> ()
        let stopTrackingChanges: () -> ()
        
        init(name: String? = nil, connectionState: ConnectionState, displayData: [DisplayableValue], rssi: DisplayableRSSI, connectable: Bool, connect: @escaping () -> Void, disconnect: @escaping () -> Void, startTrackingChanges: @escaping () -> Void, stopTrackingChanges: @escaping () -> Void) {
            self.name = name
            self.connectionState = connectionState
            self.displayData = displayData
            self.rssi = rssi
            self.connectable = connectable
            self.connect = connect
            self.disconnect = disconnect
            self.startTrackingChanges = startTrackingChanges
            self.stopTrackingChanges = stopTrackingChanges
        }
    }
    
    enum ConnectionState {
        case connected, disconnected, connecting, disconnecting, error(Error)
    }
}
