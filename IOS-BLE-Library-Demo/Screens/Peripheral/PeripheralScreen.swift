//
//  PeripheralScreen.swift
//  IOS-BLE-Library-Demo
//
//  Created by Nick Kibysh on 29/09/2023.
//

import SwiftUI

struct PeripheralScreen: View {
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        PeripheralView()
            .environmentObject(viewModel.environment)
    }
}

struct PeripheralView: View {
    @EnvironmentObject var peripheralEnv: PeripheralScreenEnvironment
    
    var body: some View {
        VStack {
            Form {
                ContentCardGrid(data: [DisplayableValue(id: "rssi", description: "rssi", value: peripheralEnv.rssi)] +  peripheralEnv.displayData)
            }
            Spacer()
            ConnectionButton()
        }
        .navigationTitle(peripheralEnv.name ?? "Unnamed")
    }
}

#Preview {
    PeripheralView()
        .environmentObject(
            PeripheralScreenEnvironment(
                displayData: [DisplayableValue(id: "man.data", description: "man.data", value: Data([0x00,0x01]))],
                rssi: DisplayableRSSI(rssi: -60)
            )
        )
}
