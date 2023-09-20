//
//  ContentView.swift
//  BLES-Demo
//
//  Created by Nick Kibysh on 20/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentView.ViewModel()
    
    var body: some View {
        if viewModel.showContent {
            ScannerView(
                state: viewModel.state,
                scanResults: viewModel.scanResults,
                isScanning: $viewModel.isScanning
            )
        } else {
            notStartedView()
        }
    }
    
    @ViewBuilder func notStartedView() -> some View {
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
    ContentView(viewModel: ContentView.ViewModel())
}
