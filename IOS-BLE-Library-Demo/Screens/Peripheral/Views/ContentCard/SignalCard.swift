//
//  SignalCard.swift
//  IOS-BLE-Library-Demo
//
//  Created by Nick Kibysh on 01/10/2023.
//

import SwiftUI

struct SignalCard: View {
    let rssi: DisplayableRSSI
    
    var body: some View {
        VStack(alignment: .leading) {
            SignalLevelView(signalLevel: ScanResult.SignalLevel(rssi: rssi.rssi))
            Text("\(rssi.rssi) dBm")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    Form {
        Grid {
            GridRow {
                SignalCard(rssi: DisplayableRSSI(rssi: -50))
                SignalCard(rssi: DisplayableRSSI(rssi: -60))
                SignalCard(rssi: DisplayableRSSI(rssi: -70))
            }
            GridRow {
                SignalCard(rssi: DisplayableRSSI(rssi: -80))
                SignalCard(rssi: DisplayableRSSI(rssi: -90))
                SignalCard(rssi: DisplayableRSSI(rssi: -100))
            }
            GridRow {
                SignalCard(rssi: DisplayableRSSI(rssi: -110))
                SignalCard(rssi: DisplayableRSSI(rssi: -50))
                SignalCard(rssi: DisplayableRSSI(rssi: -50))
            }
        }
    }
}
