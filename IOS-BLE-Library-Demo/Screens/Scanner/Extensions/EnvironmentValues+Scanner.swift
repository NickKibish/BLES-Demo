//
//  EnvironmentValues+Scanner.swift
//  IOS-BLE-Library-Demo
//
//  Created by Nick Kibysh on 29/09/2023.
//

import SwiftUI

struct Action: EnvironmentKey {
    static var defaultValue: () -> () = {}
}

extension BluetoothState: EnvironmentKey {
    static var defaultValue = Self.unknown
}

extension Bool: EnvironmentKey {
    public static var defaultValue: Bool = false
}

extension EnvironmentValues {
    var startScan: () -> () {
        get { self[Action.self] }
        set { self[Action.self] = newValue }
    }
    
    var stopScan: () -> () {
        get { self[Action.self] }
        set { self[Action.self] = newValue }
    }
    
    var bluetoothState: BluetoothState {
        get { self[BluetoothState.self] }
        set { self[BluetoothState.self] = newValue }
    }
    
    var isScanning: Bool {
        get { self[Bool.self] }
        set { self[Bool.self] = newValue }
    }
}
