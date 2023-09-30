//
//  BluetoothState+CBManagerState.swift
//  IOS-BLE-Library-Demo
//
//  Created by Nick Kibysh on 30/09/2023.
//

import Foundation
import CoreBluetooth

extension BluetoothState {
    init(managerState: CBManagerState) {
        switch managerState {
        case .unknown:
            self = .unknown
        case .resetting:
            self = .resetting
        case .unsupported:
            self = .unsupported
        case .unauthorized:
            self = .unauthorized
        case .poweredOff:
            self = .poweredOff
        case .poweredOn:
            self = .poweredOn
        @unknown default:
            fatalError()
        }
    }
}
