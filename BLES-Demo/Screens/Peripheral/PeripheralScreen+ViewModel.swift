//
//  ViewModel.swift
//  BLES-Demo
//
//  Created by Nick Kibysh on 26/09/2023.
//

import Combine
import Foundation
import iOS_BLE_Library_Mock

extension PeripheralScreen {
    @MainActor
    class ViewModel: ObservableObject {
        @Published var name: String = ""
        @Published var connectable: Bool = false
        @Published var connectionState: ConnectionButton.ConnectionState = .disconnected
        @Published var advertisementData: [DisplayableTextValue] = []
        
        let uuid: UUID
        let centralManager: CentralManager
        
        private var liveUpdateCancelable = Set<AnyCancellable>()
        
        init(id: UUID, name: String, advertisementData: [String:Any], centralManager: CentralManager) {
            self.uuid = id
            self.name = name
            let ad = AdvertisementData(advertisementData)
            self.connectable = ad.isConnectable ?? false 
            self.advertisementData = ad.displayableArray
            
            self.centralManager = centralManager
        }
    }
}

extension PeripheralScreen.ViewModel {
    func turnOnLiveUpdate() {
        centralManager.scanResultsChannel
            .print()
            .filter { $0.peripheral.identifier == self.uuid }
            .sink { scanResult in
                self.name = scanResult.name ?? "n/a"
                self.advertisementData = scanResult.advertisementData.displayableArray
                self.connectable = scanResult.advertisementData.isConnectable ?? false
                
                self.advertisementData.append(DisplayableTextValue(id: "rssi", description: "Rssi", value: scanResult.rssi.value))
            }
            .store(in: &liveUpdateCancelable)
    }
    
    func turnOffLiveUpdate() {
        liveUpdateCancelable.removeAll()
    }
    
    func connect() {
        connectionState = .connecting
    }
    
    func disconnect() {
        connectionState = .disconnecting
    }
}
