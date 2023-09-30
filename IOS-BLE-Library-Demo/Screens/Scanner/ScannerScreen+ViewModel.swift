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
            started: false,
            isScanning: false,
            bluetoothState: .unknown,
            scanResults: [],
            startScan: { [weak self] in self?.startScan() },
            stopScan: { [weak self] in self?.stopScan() },
            peripheralViewModel: { [unowned self] sr in self.peripheralViewModel(for: sr) }
        )
        
        private var cancelable = Set<AnyCancellable>()
        
        init() {
            
        }
    }
}

extension ScannerScreen.ViewModel {
    func startScan() {
        environment.started = true
    }
    
    func stopScan() {
    }
}

extension ScannerScreen.ViewModel {
    func peripheralViewModel(for scanResult: ScanResult) -> PeripheralScreen.ViewModel {
        PeripheralScreen.ViewModel(scanResult: scanResult)
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


