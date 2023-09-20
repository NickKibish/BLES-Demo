//
//  ViewModel.swift
//  BLES-Demo
//
//  Created by Nick Kibysh on 20/09/2023.
//

import SwiftUI

extension ContentView {
    @MainActor
    class ViewModel: ObservableObject {
        @Published var showContent: Bool = false
        @Published var scanResults: [ScanResult] = []
        @Published var isScanning: Bool = false 
        @Published var state: BluetoothState = .unknown
    }
}

extension ContentView.ViewModel {
    func startScan() {
        showContent = true
        isScanning = true
    }
}
