//
//  CBUUIDs.swift
//  MeterProIOAF
//
//  Created by Raf on 2/21/23.
//


import Foundation
import CoreBluetooth

struct CBUUIDs{

   // static let dcppcSericeUUID = "6E400001-B5A3-F393-E0A9-E50E24DCCA9E"
    static let kBLEService_UUID = "6E400001-B5A3-F393-E0A9-E50E24DCCA9E"
   // static let kBLE_Characteristic_uuid_Tx = "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"
   // static let kBLE_Characteristic_uuid_Rx = "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"
    
    static let kBLE_Characteristic_uuid_Rx = "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"
    static let kBLE_Characteristic_uuid_Tx = "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"
    
    
   // static let kBLEService_UUID = "6e400001-b5a3-f393-e0a9-e50e24dcca9e"
   // static let kBLE_Characteristic_uuid_Tx = "6e400002-b5a3-f393-e0a9-e50e24dcca9e"
   // static let kBLE_Characteristic_uuid_Rx = "6e400003-b5a3-f393-e0a9-e50e24dcca9e"
    static let MaxCharacters = 20

    static let BLEService_UUID = CBUUID(string: kBLEService_UUID)
    //static let BLEService_UUID = CBUUID(string: dcppcSericeUUID)
    static let BLE_Characteristic_uuid_Tx = CBUUID(string: kBLE_Characteristic_uuid_Tx)//(Property = Write without response)
    static let BLE_Characteristic_uuid_Rx = CBUUID(string: kBLE_Characteristic_uuid_Rx)// (Property = Read/Notify)

}

