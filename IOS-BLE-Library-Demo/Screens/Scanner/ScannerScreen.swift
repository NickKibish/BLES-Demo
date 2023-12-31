//
//  ScannerScreen.swift
//  IOS-BLE-Library-Demo
//
//  Created by Nick Kibysh on 28/09/2023.
//

import SwiftUI

struct ScannerScreen: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        ScannerView()
            .environmentObject(viewModel.environment)
    }
}

struct ScannerView: View {
    @EnvironmentObject var scannerEnv: ScannerScreenEnvironment
    
    var body: some View {
        if scannerEnv.started {
            NavigationSplitView {
                VStack {
                    ScanResultList()
                    ScanControl()
                        .padding()
                }
                .navigationTitle("Scanner")
            } detail: {
                Text("Hello World!")
            }
        } else {
            NotStartedView()
        }

    }
}

#Preview {
    ScannerView()
        .environmentObject(ScannerScreenEnvironment(
            started: true,
            isScanning: true,
            bluetoothState: .poweredOn,
            scanResults: [
                ScanResult(name: "Device", rssi: 0, id: UUID(), advertisementData: [:]),
                ScanResult(name: nil, rssi: 0, id: UUID(), advertisementData: [:]),
            ]
        ))
}

#Preview {
    ScannerView()
        .environmentObject(ScannerScreenEnvironment(
            started: true,
            isScanning: true,
            bluetoothState: .poweredOn,
            scanResults: []
        ))
}

#Preview {
    ScannerView()
        .environmentObject(ScannerScreenEnvironment())
}
