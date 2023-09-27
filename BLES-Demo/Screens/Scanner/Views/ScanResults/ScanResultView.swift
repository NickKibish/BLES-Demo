//
//  ScanResultView.swift
//  BLES-Demo
//
//  Created by Nick Kibysh on 20/09/2023.
//

import SwiftUI

struct ScanResultView: View {
    let name: String?
    let signalLevel: ScanResult.SignalLevel
    
    var body: some View {
        HStack {
            SignalLevelView(signalLevel: signalLevel)
            if let name {
                Text(name)
            } else {
                Text("n/a")
                    .foregroundStyle(.secondary)
            }
        }
        
    }
}

#Preview {
    List {
        ScanResultView(name: nil, signalLevel: .excellent)
        ScanResultView(name: "Scan Result", signalLevel: .good)
    }
}
