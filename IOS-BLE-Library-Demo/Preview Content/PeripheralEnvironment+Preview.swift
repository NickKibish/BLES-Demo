//
//  PeripheralEnvironment+Preview.swift
//  IOS-BLE-Library-Demo
//
//  Created by Nick Kibysh on 30/09/2023.
//

import Foundation

extension PeripheralScreen.ViewModel.Environment {
    convenience init(name: String? = nil, connectionState: PeripheralScreen.ViewModel.ConnectionState = .disconnected, displayData: [DisplayableTextValue] = []) {
        self.init(name: name, connectionState: connectionState, displayData: displayData, connectable: true, connect: { }, disconnect: { })
    }
}
