//
//  AdvertisementData+Displayable.swift
//  IOS-BLE-Library-Demo
//
//  Created by Nick Kibysh on 01/10/2023.
//

import Foundation
import CoreBluetooth

func mapAdvertisementData(_ ad: [String:Any]) -> [DisplayableValue] {
    var displayable: [DisplayableValue] = []
    if let localName = ad[CBAdvertisementDataLocalNameKey] as? String {
        displayable.append(DisplayableValue(id: "localName", description: "Local Name", value: localName))
    }

    if let txPowerLevel = ad[CBAdvertisementDataTxPowerLevelKey] as? NSNumber {
        displayable.append(DisplayableValue(id: "txPowerLevel", description: "TX Power Level", value: txPowerLevel.intValue))
    }

    if let manufacturerData = ad[CBAdvertisementDataManufacturerDataKey] as? Data {
        displayable.append(DisplayableValue(id: "manufacturerData", description: "Manufacturer Data", value: manufacturerData))
    }

    if let serviceData = ad[CBAdvertisementDataServiceDataKey] as? [CBUUID:Data] {
        displayable.append(DisplayableValue(id: "serviceData", description: "Service Data", value: serviceData))
    }

    if let serviceUUIDs = ad[CBAdvertisementDataServiceUUIDsKey] as? [CBUUID] {
        displayable.append(DisplayableValue(id: "serviceUUIDs", description: "Service UUIDs", value: serviceUUIDs))
    }

    if let overflowServiceUUIDs = ad[CBAdvertisementDataOverflowServiceUUIDsKey] as? [CBUUID] {
        displayable.append(DisplayableValue(id: "overflowServiceUUIDs", description: "Overflow Service UUIDs", value: overflowServiceUUIDs))
    }

    if let solicitedServiceUUIDs = ad[CBAdvertisementDataSolicitedServiceUUIDsKey] as? [CBUUID] {
        displayable.append(DisplayableValue(id: "solicitedServiceUUIDs", description: "Solicited Service UUIDs", value: solicitedServiceUUIDs))
    }

    if let isConnectable = ad[CBAdvertisementDataIsConnectable] as? NSNumber {
        displayable.append(DisplayableValue(id: "isConnectable", description: "Is Connectable", value: isConnectable.boolValue))
    }

    return displayable
}
