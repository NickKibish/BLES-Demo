//
//  AdvertisementData+Ext.swift
//  BLES-Demo
//
//  Created by Nick Kibysh on 27/09/2023.
//

import Foundation
import iOS_BLE_Library_Mock

extension AdvertisementData {
    var displayableArray: [DisplayableTextValue] {
        var displayable: [DisplayableTextValue] = []
        self.localName.map { displayable.append(DisplayableTextValue(id: "localName", description: "Local Name", value: $0)) }
        self.txPowerLevel.map { displayable.append(DisplayableTextValue(id: "txPowerLevel", description: "TX Power Level", value: $0)) }
        self.manufacturerData.map { displayable.append(DisplayableTextValue(id: "manufacturerData", description: "Manufacturer Data", value: $0)) }
        self.serviceData.map { displayable.append(DisplayableTextValue(id: "serviceData", description: "Service Data", value: $0)) }
        self.serviceUUIDs.map { displayable.append(DisplayableTextValue(id: "serviceUUIDs", description: "Service UUIDs", value: $0)) }
        self.overflowServiceUUIDs.map { displayable.append(DisplayableTextValue(id: "overflowServiceUUIDs", description: "Overflow Service UUIDs", value: $0)) }
        self.solicitedServiceUUIDs.map { displayable.append(DisplayableTextValue(id: "solicitedServiceUUIDs", description: "Solicited Service UUIDs", value: $0)) }
        self.isConnectable.map { displayable.append(DisplayableTextValue(id: "isConnectable", description: "Is Connectable", value: $0)) }
        return displayable
    }
}
