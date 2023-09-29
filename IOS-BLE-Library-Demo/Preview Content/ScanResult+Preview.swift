//
//  ScanResult+Preview.swift
//  IOS-BLE-Library-Demo
//
//  Created by Nick Kibysh on 30/09/2023.
//

import Foundation

extension ScanResult {
    static var empty: ScanResult {
        ScanResult(name: nil, signal: .noSignal, id: UUID(), advertisementData: [:])
    }
}
