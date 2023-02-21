//
//  BlePeripheral.swift
//  MeterProIOAF
//
//  Created by Raf on 2/21/23.
//

import Foundation
import CoreBluetooth

class BlePeripheral {
 static var connectedPeripheral: CBPeripheral?
 static var connectedService: CBService?
 static var connectedTXChar: CBCharacteristic?
 static var connectedRXChar: CBCharacteristic?
}
