//
//  BluetoothState.swift
//  IOS-BLE-Library-Demo
//
//  Created by Nick Kibysh on 29/09/2023.
//

import Foundation

enum BluetoothState {
    case unknown
    case resetting
    case unsupported
    case unauthorized
    case poweredOff
    case poweredOn

    var localizedDescription: String {
        switch self {
        case .unknown:
            return "Unknown"
        case .resetting:
            return "Resetting"
        case .unsupported:
            return "Unsupported"
        case .unauthorized:
            return "Unauthorized"
        case .poweredOff:
            return "Powered Off"
        case .poweredOn:
            return "Powered On"
        }
    }
}

