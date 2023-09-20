//
//  ScannerView.swift
//  BLES-Demo
//
//  Created by Nick Kibysh on 20/09/2023.
//

import SwiftUI

struct ScannerView: View {
    let state: BluetoothState
    let scanResults: [ScanResult]
    
    @Binding var isScanning: Bool
    
    let startScan: () -> ()
    let stopScan: () -> ()
    
    var body: some View {
        VStack {
            Spacer()
            ScanResultList(scanResults: scanResults, isScanning: isScanning)
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
        startScan: {},
        stopScan: {}
    )
}

#Preview {
    ScannerView(
        state: .poweredOn,
        scanResults: [],
        isScanning: .constant(true),
        startScan: {},
        stopScan: {}
    )
}

#Preview {
    ScannerView(
        state: .poweredOn,
        scanResults: [
            ScanResult(name: "Blinki", signal: .good, id: UUID()),
            ScanResult(name: "nRF-DK", signal: .bad, id: UUID()),
            ScanResult(name: "Keyboard", signal: .excellent, id: UUID()),
            ScanResult(name: nil, signal: .ok, id: UUID()),
        ],
        isScanning: .constant(true),
        startScan: {},
        stopScan: {}
    )
}
