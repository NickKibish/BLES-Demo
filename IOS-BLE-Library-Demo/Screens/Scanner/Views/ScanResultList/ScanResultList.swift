//
//  ScanResultList.swift
//  IOS-BLE-Library-Demo
//
//  Created by Nick Kibysh on 29/09/2023.
//

import SwiftUI

struct ScanResultList: View {
    @EnvironmentObject var scannerEnv: ScannerScreen.ViewModel.Environment
    
    var body: some View {
        if scannerEnv.scanResults.isEmpty {
            VStack {
                Spacer()
                Image(systemName: "binoculars")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    .foregroundStyle(.secondary)
                Spacer()
            }
        } else {
            List(scannerEnv.scanResults) { sr in
                NavigationLink {
                    PeripheralScreen(viewModel: scannerEnv.peripheralViewModel(sr) )
                } label: {
                    ScanResultItem(name: sr.name, signalLevel: sr.signal)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ScanResultList()
            .environmentObject(ScannerScreenEnvironment(
                scanResults: []
            ))
    }
}

#Preview {
    NavigationStack {
        ScanResultList()
            .environmentObject(ScannerScreenEnvironment(
                scanResults: [
                    ScanResult(name: "Device", rssi: 0, id: UUID(), advertisementData: [:])
                ]
            ))
    }
}
