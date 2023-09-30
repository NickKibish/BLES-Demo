//
//  ScanResultEnvironment.swift
//  IOS-BLE-Library-Demo
//
//  Created by Nick Kibysh on 29/09/2023.
//

import Foundation

extension ScannerScreen.ViewModel.Environment {
    convenience init(started: Bool = false, isScanning: Bool = false, bluetoothState: BluetoothState = .unknown, scanResults: [ScanResult] = [])  {
        
        self.init(
            started: started,
            isScanning: isScanning,
            bluetoothState: bluetoothState,
            scanResults: scanResults,
            startScan: { }, stopScan: { },
            peripheralViewModel: { _ in PeripheralScreen.ViewModel(scanResult: ScanResult(name: "Scan Result", signal: .good, id: UUID(), advertisementData: [:])) }
        )
    }
}
