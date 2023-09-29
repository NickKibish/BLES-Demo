//
//  ScanResult.swift
//  BLES-Demo
//
//  Created by Nick Kibysh on 20/09/2023.
//

import Foundation

struct ScanResult: Identifiable, Hashable {
    static func == (lhs: ScanResult, rhs: ScanResult) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    enum SignalLevel: Int {
        case excellent, good, ok, bad, noSignal

        init(rssi: Int) {
            switch rssi {
            case -60...(-40):
                self = .excellent
            case -70...(-60):
                self = .good
            case -80...(-70):
                self = .ok
            case -90...(-80):
                self = .bad
            default:
                self = .noSignal
            }
        }
    }
    
    let name: String?
    let signal: SignalLevel
    let id: UUID
    let advertisementData: [String: Any]
}
