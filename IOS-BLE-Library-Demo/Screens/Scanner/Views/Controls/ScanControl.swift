//
//  ScanControl.swift
//  IOS-BLE-Library-Demo
//
//  Created by Nick Kibysh on 29/09/2023.
//

import SwiftUI

struct ScanControl: View {
    @EnvironmentObject var scannerEnv: ScannerScreenEnvironment
    
    var body: some View {
        HStack {
            BluetoothStateBadge(state: scannerEnv.bluetoothState)
            Spacer()
            if scannerEnv.isScanning {
                ProgressView()
            }
            Spacer()
            Button(
                action: {
                    if scannerEnv.isScanning {
                        scannerEnv.stopScan()
                    } else {
                        scannerEnv.startScan()
                    }
                }, label: {
                    if scannerEnv.isScanning {
                        Label("Stop Scan", systemImage: "stop")
                            .symbolVariant(.fill)
                    } else {
                        Label("Start Scan", systemImage: "play")
                            .symbolVariant(.fill)
                    }
                }
            )
            .buttonStyle(.bordered)
            .foregroundStyle(
                scannerEnv.bluetoothState != .poweredOn
                ? .gray
                : scannerEnv.isScanning
                    ? .red
                    : .blue
            )
            .disabled(scannerEnv.bluetoothState != .poweredOn)
        }
    }
}

#Preview {
    List {
        ScanControl()
            .environmentObject(ScannerScreenEnvironment(isScanning: true, bluetoothState: .poweredOn))
        ScanControl()
            .environmentObject(ScannerScreenEnvironment(isScanning: false, bluetoothState: .poweredOn))
        ScanControl()
            .environmentObject(ScannerScreenEnvironment(isScanning: false, bluetoothState: .unauthorized))
    }
}
