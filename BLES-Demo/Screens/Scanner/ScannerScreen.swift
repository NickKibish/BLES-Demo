//
//  ScannerScreen.swift
//  BLES-Demo
//
//  Created by Nick Kibysh on 20/09/2023.
//

import SwiftUI

struct ScannerScreen: View {
    
    @StateObject var viewModel = ScannerScreen.ViewModel()
    
    var body: some View {
        if viewModel.showContent {
            NavigationStack {
                ScannerView(
                    state: viewModel.state,
                    scanResults: viewModel.scanResults,
                    isScanning: $viewModel.isScanning,
                    navigation: { PeripheralScreen(viewModel: viewModel.peripheralViewModel($0)) },
                    startScan: { viewModel.startScan() },
                    stopScan: { viewModel.stopScan() }
                )
                .navigationTitle("Scanner")
            }
        } else {
            notStartedView()
        }
    }
    
    @ViewBuilder 
    func notStartedView() -> some View {
        NoContentView(
            systemName: "scanner",
            title: "Start Scan",
            message: "Scanning is not started yet") {
                Text("Start Scan")
            } action: {
                viewModel.startScan()
            }
    }
}

#Preview {
    ScannerScreen(viewModel: ScannerScreen.ViewModel())
}
