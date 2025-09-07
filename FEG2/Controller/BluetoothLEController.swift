//
//  BluetoothLEController.swift
//  FEG2
//
//  Created by ishida fumiaki on 2025/09/05.
//

import SwiftUI
import Foundation
import CoreBluetooth

enum  BLE_CON_STATUS {
   case SCANNING
   case CONNECTED
   case DISCONNECTING
   case DISCONNECTED
}

class BluetoothLEController: NSObject, ObservableObject {
    @Published var temp_f: Float = 0.0
    @Published var temp_s: Float = 0.0
    @Published var bleState: BLE_CON_STATUS = .DISCONNECTED
    @Published var bluetooth_ON: Bool = false
    
    private var centralManager: CBCentralManager?
    private var peripheral: CBPeripheral?
    
    private var notTargetDevices: [String] = []
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
}

extension BluetoothLEController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
            case .unknown:
                print("unknown")
            case .resetting:
                print("resetting")
            case .unsupported:
                print("unsupported")
            case .unauthorized:
                print("unauthorized")
            case .poweredOff:
                bluetooth_ON = false
                print("poweredOff")
            case .poweredOn:
                bluetooth_ON = true
                print("poweredOn")
            @unknown default:
                print("unknown")
        }
    }
    
    func scanOrDissconect() {
        switch bleState {
        case .SCANNING:
            scan_stop()
        case .CONNECTED:
            disconnect()
        case .DISCONNECTING:
            break
        case .DISCONNECTED:
            scan_start()
        }
    }
    
    func scan_start() {
        if(bluetooth_ON) {
            centralManager?.scanForPeripherals(withServices: nil, options: nil)
            bleState = .SCANNING
        }
    }
    
    func scan_stop() {
        centralManager?.stopScan()
        disconnect()
    }
    
    func disconnect() {
        guard let peripheral = self.peripheral else { return }
        centralManager?.cancelPeripheralConnection(peripheral)
        bleState = .DISCONNECTED
    }
    
    //scanで端末が見つかると、呼ばれるコールバック
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        
        let localName = advertisementData[CBAdvertisementDataLocalNameKey]
//        print("Peripheralデバイスを発見しました: \(peripheral.name ?? "名前不明") - RSSI: \(RSSI) Local Name - \(localName ?? "null")")
        
        if localName != nil {
            let device_name = localName as! String
            if(!notTargetDevices.contains(device_name)){
                
//                notTargetDevices.append(device_name)
                self.peripheral = peripheral
                centralManager?.connect(peripheral, options: nil)
                central.stopScan()
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Peripheralデバイスと接続しました: \(peripheral.name ?? "名前不明")")
        peripheral.delegate = self
        peripheral.discoverServices(nil)
    }
    
}

extension BluetoothLEController: CBPeripheralDelegate {
    // 接続後ServiceUUIDのCheck
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: (any Error)?) {
        if let error = error {
            print("サービス探索に失敗しました: \(error.localizedDescription)")
            return
        }
        
        guard let services = peripheral.services else { return }
        print("サービス数: \(services.count)")
        
        for service in services {
            print("サービス UUID: \(service.uuid)")
            if service.uuid == CBUUID(string: Constants.SERVICE_UUID) {
                print("サービスが見つかりました。目的のデバイスです。")
                peripheral.discoverCharacteristics(nil, for: service)
                
                return
            }
        }
        
        print(#function, "目的のサービスが見つかりません。")
        disconnect()
        scan_start()
    }
    
    // 目的のServiceを持ったデバイスを発見後Charactaristicの検索
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let error = error {
            print("Characteristicの探索中にエラーが発生しました: \(error.localizedDescription)")
            return
        }
        guard let characteristics = service.characteristics else { return }
        
        for characteristic in characteristics {
            if characteristic.uuid == CBUUID(string: Constants.CHARACTERISTIC_UUID_F) {
                peripheral.setNotifyValue(true, for: characteristic)
            }
            if characteristic.uuid == CBUUID(string: Constants.CHARACTERISTIC_UUID_S) {
                peripheral.setNotifyValue(true, for: characteristic)
            }
        }
        
        bleState = .CONNECTED
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("Characteristicの値の読み取り中にエラーが発生しました: \(error.localizedDescription)")
            return
        }
        // 値が取得できたか確認
        guard let data = characteristic.value else {
            print("Characteristicの値が存在しません")
            return
        }
    
        
        let floatData = data[4..<8]
        let value = floatData.withUnsafeBytes { $0.load(as: Float.self) }
        print("\(value)")
        
        if characteristic.uuid == CBUUID(string: Constants.CHARACTERISTIC_UUID_F) {
            print("f char callback")
            self.temp_f = value
        }
        if characteristic.uuid == CBUUID(string: Constants.CHARACTERISTIC_UUID_S) {
            self.temp_s = value
        }
    }
    
    
}
