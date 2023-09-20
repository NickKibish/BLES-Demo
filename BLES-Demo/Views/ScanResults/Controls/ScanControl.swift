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
    
    var body: some View {
        HStack {
            BluetoothStateBadge(state: state)
            Spacer()
            Button(
                action: {
                    isScanning.toggle()
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
        ScanControl(isScanning: .constant(true), state: .poweredOn)
        ScanControl(isScanning: .constant(false), state: .poweredOff)
        ScanControl(isScanning: .constant(false), state: .unknown)
    }
}
