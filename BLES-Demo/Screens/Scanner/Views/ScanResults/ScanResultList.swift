//
//  ScanResultList.swift
//  BLES-Demo
//
//  Created by Nick Kibysh on 20/09/2023.
//

import SwiftUI

struct ScanResultList<Destination: View>: View {
    let scanResults: [ScanResult]
    let isScanning: Bool
    let navigation: (UUID) -> Destination
    
    var body: some View {
        if scanResults.isEmpty {
            noResults
        } else {
            scanResultsList
        }
    }
    
    @ViewBuilder
    private var scanResultsList: some View {
        List(scanResults) { scanResult in
            NavigationLink {
                navigation(scanResult.id)
            } label: {
                ScanResultView(name: scanResult.name, signalLevel: scanResult.signal)
            }

        }
    }
    
    @ViewBuilder
    private var noResults: some View {
        VStack {
            Image(systemName: imageName)
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)
                .foregroundStyle(.secondary)
            
            Text(title)
                .font(.title)
                .foregroundStyle(.secondary)
        }
    }
    
    private var imageName: String {
        isScanning ? "scanner" : "list.bullet"
    }
    
    private var title: String {
        isScanning ? "Scanning . . ." : "No Scan Results"
    }
}

#Preview {
    NavigationStack {
        ScanResultList(scanResults: [
            
        ], isScanning: true) { _ in
            EmptyView()
        }
    }
}

#Preview {
    NavigationStack {
        ScanResultList(scanResults: [
            
        ], isScanning: false) { _ in
            EmptyView()
        }
    }
}

#Preview {
    NavigationStack {
        ScanResultList(scanResults: [
            ScanResult(name: "Scan Result", signal: .excellent, id: UUID(), advertisementData: [:])
        ], isScanning: true) { _ in
            EmptyView()
        }
    }
}
