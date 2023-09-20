//
//  ScanResult.swift
//  BLES-Demo
//
//  Created by Nick Kibysh on 20/09/2023.
//

import Foundation

struct ScanResult: Identifiable {
    enum SignalLevel: Int {
        case excellent, good, ok, bad, noSignal
    }
    
    let name: String?
    let signal: SignalLevel
    let id: UUID
}
