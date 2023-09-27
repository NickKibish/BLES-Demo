//
//  ScannerView.swift
//  BLES-Demo
//
//  Created by Nick Kibysh on 20/09/2023.
//

import SwiftUI

struct ScannerView<Destination: View>: View {
    let state: BluetoothState
    let scanResults: [ScanResult]
    
    @Binding var isScanning: Bool
    
    let navigation: (UUID) -> Destination
    
    let startScan: () -> ()
    let stopScan: () -> ()
    
    var body: some View {
        VStack {
            Spacer()
            ScanResultList(scanResults: scanResults, isScanning: isScanning, navigation: navigation)
            Spacer()
            ScanControl(
                isScanning: $isScanning,
                state: state,
                startScan: startScan,
                stopScan: stopScan
            )
            .frame(height: 50)
            .padding()
        }
    }
}

#Preview {
    ScannerView(
        state: .unknown,
        scanResults: [],
        isScanning: .constant(false),
        navigation: { _ in EmptyView() },
        startScan: {},
        stopScan: {}
    )
}

#Preview {
    ScannerView(
        state: .poweredOn,
        scanResults: [],
        isScanning: .constant(true),
        navigation: { _ in EmptyView() },
        startScan: {},
        stopScan: {}
    )
}

#Preview {
    ScannerView(
        state: .poweredOn,
        scanResults: [
            ScanResult(name: "Blinki", signal: .good, id: UUID(), advertisementData: [:]),
            ScanResult(name: "nRF-DK", signal: .bad, id: UUID(), advertisementData: [:]),
            ScanResult(name: "Keyboard", signal: .excellent, id: UUID(), advertisementData: [:]),
            ScanResult(name: nil, signal: .ok, id: UUID(), advertisementData: [:]),
        ],
        isScanning: .constant(true),
        navigation: { _ in EmptyView() },
        startScan: {},
        stopScan: {}
    )
}
