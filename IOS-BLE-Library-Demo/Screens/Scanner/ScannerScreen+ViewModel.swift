//
//  ScannerScreen+ViewModel.swift
//  IOS-BLE-Library-Demo
//
//  Created by Nick Kibysh on 28/09/2023.
//

import Foundation
import Combine

typealias ScannerScreenEnvironment = ScannerScreen.ViewModel.Environment

extension ScannerScreen {
    class ViewModel: ObservableObject {
        lazy private (set) var environment = Environment(
            isScanning: false,
            bluetoothState: .unknown,
            scanResults: [],
            startScan: { [weak self] in self?.startScan() },
            stopScan: { [weak self] in self?.stopScan() },
            peripheralViewModel: { [unowned self] sr in self.peripheralViewModel(for: sr) }
        )
        
        init() {
            self.environment = Environment(
                isScanning: true,
                bluetoothState: .poweredOn,
                scanResults: [ScanResult(name: "Scan Result", signal: .good, id: UUID(), advertisementData: [:])],
                startScan: { self.startScan() },
                stopScan: { self.stopScan() },
                peripheralViewModel: { _ in PeripheralScreen.ViewModel(scanResult: .empty) }
            )
        }
    }
}

extension ScannerScreen.ViewModel {
    func startScan() {
        self.environment.isScanning = true
    }
    
    func stopScan() {
        self.environment.isScanning = false
    }
}

extension ScannerScreen.ViewModel {
    func peripheralViewModel(for scanResult: ScanResult) -> PeripheralScreen.ViewModel {
        PeripheralScreen.ViewModel(scanResult: scanResult)
    }
}

extension ScannerScreen.ViewModel {
    class Environment: ObservableObject {
        @Published var isScanning: Bool = false
        @Published var bluetoothState: BluetoothState = .unknown
        @Published var scanResults: [ScanResult] = []
        
        let startScan: () -> ()
        let stopScan: () -> ()
        let peripheralViewModel: (ScanResult) -> PeripheralScreen.ViewModel
        
        init(isScanning: Bool, bluetoothState: BluetoothState, scanResults: [ScanResult], startScan: @escaping () -> Void, stopScan: @escaping () -> Void, peripheralViewModel: @escaping (ScanResult) -> PeripheralScreen.ViewModel) {
            self.isScanning = isScanning
            self.bluetoothState = bluetoothState
            self.scanResults = scanResults
            self.startScan = startScan
            self.stopScan = stopScan
            self.peripheralViewModel = peripheralViewModel
        }
    }
}


