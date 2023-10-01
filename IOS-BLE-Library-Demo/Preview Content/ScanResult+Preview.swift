//
//  ScanResult+Preview.swift
//  IOS-BLE-Library-Demo
//
//  Created by Nick Kibysh on 30/09/2023.
//

import Foundation

extension ScanResult {
    static var empty: ScanResult {
        ScanResult(name: nil, rssi: 0, id: UUID(), advertisementData: [:])
    }
}
