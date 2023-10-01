//
//  ScannerScreen+ViewModel.swift
//  IOS-BLE-Library-Demo
//
//  Created by Nick Kibysh on 28/09/2023.
//

import Foundation
import Combine
import iOS_BLE_Library
import CoreBluetooth

typealias ScannerScreenEnvironment = ScannerScreen.ViewModel.Environment

extension ScannerScreen {
    class ViewModel: ObservableObject {
        lazy private (set) var environment = Environment(
            started: false,
            isScanning: false,
            bluetoothState: .unknown,
            scanResults: [],
            startScan: { [weak self] in self?.startScan() },
            stopScan: { [weak self] in self?.stopScan() },
            peripheralViewModel: { [unowned self] sr in self.peripheralViewModel(for: sr) }
        )
        
        private var cancelable = Set<AnyCancellable>()
        
        let centralManager = CentralManager()
        
        init() {
            centralManager.stateChannel
                .map { BluetoothState(managerState: $0) }
                .assign(to: &environment.$bluetoothState)
            
            centralManager.isScanningChannel
                .assign(to: &environment.$isScanning)
        }
    }
}

extension ScannerScreen.ViewModel {
    func startScan() {
        environment.started = true
        
        centralManager.scanForPeripherals(withServices: nil)
            .autoconnect()
            .map {
                ScanResult(name: $0.name, signal: ScanResult.SignalLevel(rssi: $0.rssi.value), id: $0.peripheral.identifier, advertisementData: $0.advertisementData.rawData)
            }
            .filter {
                $0.name != nil
            }
            .sink { _ in
                
            } receiveValue: {
                self.environment.scanResults.replacedOrAppended($0)
            }
            .store(in: &cancelable)
    }
    
    func stopScan() {
        centralManager.stopScan()
    }
}

extension ScannerScreen.ViewModel {
    func peripheralViewModel(for scanResult: ScanResult) -> PeripheralScreen.ViewModel {
        PeripheralScreen.ViewModel(scanResult: scanResult, centralManager: centralManager)
    }
}

extension ScannerScreen.ViewModel {
    class Environment: ObservableObject {
        @Published var started: Bool = false
        @Published var isScanning: Bool = false
        @Published var bluetoothState: BluetoothState = .unknown
        @Published var scanResults: [ScanResult] = []
        
        let startScan: () -> ()
        let stopScan: () -> ()
        let peripheralViewModel: (ScanResult) -> PeripheralScreen.ViewModel
        
        init(started: Bool, isScanning: Bool, bluetoothState: BluetoothState, scanResults: [ScanResult], startScan: @escaping () -> Void, stopScan: @escaping () -> Void, peripheralViewModel: @escaping (ScanResult) -> PeripheralScreen.ViewModel) {
            self.started = started
            self.isScanning = isScanning
            self.bluetoothState = bluetoothState
            self.scanResults = scanResults
            self.startScan = startScan
            self.stopScan = stopScan
            self.peripheralViewModel = peripheralViewModel
        }
    }
}


