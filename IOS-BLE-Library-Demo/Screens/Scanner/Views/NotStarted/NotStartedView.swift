//
//  NotStartedView.swift
//  IOS-BLE-Library-Demo
//
//  Created by Nick Kibysh on 30/09/2023.
//

import SwiftUI

struct NotStartedView: View {
    @EnvironmentObject var scannerEnv: ScannerScreenEnvironment
    
    var body: some View {
        VStack {
            Image(systemName: "binoculars")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .foregroundStyle(.secondary)
            Text("Stanner not started")
                .font(.title)
                .foregroundStyle(.secondary)
                .fontWeight(.bold)
            Button("Start Scan") {
                scannerEnv.startScan()
            }
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    NotStartedView()
        .environmentObject(ScannerScreenEnvironment())
}
