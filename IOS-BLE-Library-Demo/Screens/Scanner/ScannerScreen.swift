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
                .onAppear {
                    scannerEnv.startScan()
                }
            } detail: {
                Text("Hello World!")
            }
        } else {
            NotStartedView()
        }

    }
}

#if DEBUG
private struct Preview {
    static let sr = ScanResult(
        name: "Peripheral 1",
        signal: .good,
        id: UUID(),
        advertisementData: [:]
    )
}
#endif

#Preview {
    ScannerView()
        .environmentObject(ScannerScreenEnvironment(
            isScanning: true,
            bluetoothState: .poweredOn,
            scanResults: [
                ScanResult(name: "Device", signal: .good, id: UUID(), advertisementData: [:]),
                ScanResult(name: nil, signal: .noSignal, id: UUID(), advertisementData: [:]),
            ]
        ))
}
