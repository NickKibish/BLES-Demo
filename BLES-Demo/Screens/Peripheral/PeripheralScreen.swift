//
//  PeripheralScreen.swift
//  BLES-Demo
//
//  Created by Nick Kibysh on 26/09/2023.
//

import SwiftUI

struct PeripheralScreen: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        PeripheralView(
            advertisementData: viewModel.advertisementData,
            connectionState: viewModel.connectionState,
            connectable: viewModel.connectable,
            name: viewModel.name,
            connect: { viewModel.connect() },
            disconnect: { viewModel.disconnect() }
        )
        .onAppear {
            viewModel.turnOnLiveUpdate()
        }
        .onDisappear {
            viewModel.turnOffLiveUpdate()
        }
    }
}

struct PeripheralView: View {
    let advertisementData: [DisplayableTextValue]
    let connectionState: ConnectionButton.ConnectionState
    let connectable: Bool
    let name: String
    let connect: () -> ()
    let disconnect: () -> ()
    
    var body: some View {
        VStack {
            Form {
                ContentCardGrid(data: advertisementData)
            }
            ConnectionButton(
                state: connectionState,
                connectable: connectable,
                connect: connect,
                disconnect: disconnect
            )
            .padding()
        }
        .navigationTitle(name)
    }
}

#if DEBUG
private let data = [
    DisplayableTextValue(id: "1", description: "services", value: [1,2,4]),
    DisplayableTextValue(id: "2", description: "manuf. data", value: Data([0x00, 0x01])),
    DisplayableTextValue(id: "3", description: "tx power", value: -22),
]
#endif

#Preview {
    NavigationStack {
        PeripheralView(
            advertisementData: data,
            connectionState: .disconnected,
            connectable: true,
            name: "Peripheral",
            connect: {},
            disconnect: {}
        )
    }
}
