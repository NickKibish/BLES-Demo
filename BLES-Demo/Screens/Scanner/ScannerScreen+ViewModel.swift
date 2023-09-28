//
//  ViewModel.swift
//  BLES-Demo
//
//  Created by Nick Kibysh on 20/09/2023.
//

import SwiftUI
import iOS_BLE_Library_Mock
import Combine

extension ScannerScreen {
    @MainActor
    class ViewModel: ObservableObject {
        @Published var showContent: Bool = false
        @Published var scanResults: [ScanResult] = []
        @Published var isScanning: Bool = false 
        @Published var state: BluetoothState = .unknown
        
        private let centralManager = CentralManager()
        private var viewModels: [UUID : PeripheralScreen.ViewModel] = [:]
        private var cancelable = Set<AnyCancellable>()
        
        init() {
            centralManager.stateChannel
                .map { BluetoothState(cbState: $0) }
                .assign(to: &$state)

            centralManager.isScanningChannel
                .assign(to: &$isScanning)
        }
    }
}

extension ScannerScreen.ViewModel {
    func peripheralViewModel(_ id: UUID) -> PeripheralScreen.ViewModel {
        if let vm = viewModels[id] {
            return vm
        } else {
            let sr = scanResults.first(where: { $0.id == id })!
            let vm = PeripheralScreen.ViewModel(id: id, name: sr.name ?? "n/a", advertisementData: sr.advertisementData, centralManager: centralManager)
            viewModels[id] = vm
            return vm
        }
    }
}

extension ScannerScreen.ViewModel {
    
    func startScan() {
        showContent = true
        
        centralManager.scanForPeripherals(withServices: nil)
            .autoconnect()
            .map { sr in
                ScanResult(
                    name: sr.name,
                    signal: ScanResult.SignalLevel(rssi: sr.rssi.value),
                    id: sr.peripheral.identifier,
                    advertisementData: sr.advertisementData.rawData
                )
            }
            .filter { sr in
                sr.name != nil
//                sr.name != nil && !self.scanResults.contains(where: { $0.id == sr.id })
            }
            .timeout(.seconds(5), scheduler: DispatchQueue.main)
            .sink { _ in
                self.stopScan()
            } receiveValue: { scanResult in
                self.scanResults.replacedOrAppended(scanResult, compareBy: \.id)
            }
            .store(in: &cancelable)

    }
    
    func stopScan() {
        centralManager.stopScan()
    }
}
