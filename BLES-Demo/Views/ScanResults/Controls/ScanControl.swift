//
//  ScanControl.swift
//  BLES-Demo
//
//  Created by Nick Kibysh on 20/09/2023.
//

import SwiftUI

struct ScanControl: View {
    @Binding var isScanning: Bool
    let state: BluetoothState
    
    let startScan: () -> ()
    let stopScan: () -> ()
    
    var body: some View {
        HStack {
            BluetoothStateBadge(state: state)
            Spacer()
            Button(
                action: {
                    if isScanning {
                        startScan()
                    } else {
                        stopScan()
                    }
                }, label: {
                    Image(systemName: isScanning ? "stop" : "play")
                        .symbolVariant(.fill)
                }
            )
            .disabled(state != .poweredOn)
        }
    }
}

#Preview {
    List {
        ScanControl(isScanning: .constant(true), state: .poweredOn, startScan: {}, stopScan: {})
        ScanControl(isScanning: .constant(false), state: .poweredOff, startScan: {}, stopScan: {})
        ScanControl(isScanning: .constant(false), state: .unknown, startScan: {}, stopScan: {})
    }
}
