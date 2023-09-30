//
//  ScanResultItem.swift
//  IOS-BLE-Library-Demo
//
//  Created by Nick Kibysh on 29/09/2023.
//

import SwiftUI

struct ScanResultItem: View {
    let name: String?
    let signalLevel: ScanResult.SignalLevel
    
    var body: some View {
        Label {
            if let name {
                Text(name)
            } else {
                Text("n/a")
                    .foregroundStyle(.secondary)
            }
        } icon: {
            SignalLevelView(signalLevel: signalLevel)
        }
    }
}

#Preview {
    List {
        ScanResultItem(name: nil, signalLevel: .bad)
        ScanResultItem(name: "Device 1", signalLevel: .ok)
        ScanResultItem(name: "Device 2", signalLevel: .good)
        ScanResultItem(name: "Device 3", signalLevel: .excellent)
        ScanResultItem(name: "Device 4", signalLevel: .noSignal)
    }
}
