//
//  Displayable.swift
//  BLES-Demo
//
//  Created by Nick Kibysh on 26/09/2023.
//

import Foundation

protocol Displayable {
    
}

protocol DisplayableText: Displayable {
    var description: String { get }
}

extension String: DisplayableText { }
extension Int: DisplayableText { }

extension Double: DisplayableText {
    var description: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}

extension Array: DisplayableText {
    var description: String {
        "\(self.count) values"
    }
}

extension Dictionary: DisplayableText {
    var description: String {
        "\(self.count) values"
    }
}

extension Data: DisplayableText {
    var description: String {
        "\(self.count) bytes"
    }
}

extension Bool: DisplayableText {
    var description: String {
        self ? "Yes" : "No"
    }
}

struct DisplayableRSSI: Displayable {
    let rssi: Int
    var signal: ScanResult.SignalLevel {
        ScanResult.SignalLevel(rssi: rssi)
    }
}

struct DisplayableValue: Identifiable {
    let id: String
    let description: String
    let value: Displayable
}

