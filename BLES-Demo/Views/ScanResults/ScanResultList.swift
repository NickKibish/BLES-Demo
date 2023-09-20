//
//  ScanResultList.swift
//  BLES-Demo
//
//  Created by Nick Kibysh on 20/09/2023.
//

import SwiftUI

struct ScanResultList: View {
    let scanResults: [ScanResult]
    let isScanning: Bool
    
    var body: some View {
        if scanResults.isEmpty {
            noResults
        } else {
            scanResultsList
        }
    }
    
    @ViewBuilder
    private var scanResultsList: some View {
        List(scanResults) {
            ScanResultView(name: $0.name, signalLevel: $0.signal)
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
    ScanResultList(scanResults: [
        
    ], isScanning: true)
}

#Preview {
    ScanResultList(scanResults: [
        
    ], isScanning: false)
}

#Preview {
    ScanResultList(scanResults: [
        ScanResult(name: "Scan Result", signal: .excellent, id: UUID())
    ], isScanning: true)
}
