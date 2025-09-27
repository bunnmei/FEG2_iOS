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

enum BLE_WIRTE_TYPE {
    case TEMP_F
    case TEMP_S
    case BRIGHTNESS
}

class BluetoothLEController: NSObject, ObservableObject {
    @Published var temp_f: Float = 0.0
    @Published var temp_s: Float = 0.0
    @Published var bleState: BLE_CON_STATUS = .DISCONNECTED
    @Published var bluetooth_ON: Bool = false
    @Published var deviceName: String = "デバイス未接続"
    @AppStorage("brightness") private var sliderVal = 2
    @AppStorage("calibration_f") private var calibration_f = 0.0
    @AppStorage("calibration_s") private var calibration_s = 0.0
    
    private var centralManager: CBCentralManager?
    private var peripheral: CBPeripheral?
    
    private var brightness_characteristic: CBCharacteristic?
    private var carib_f_characteristic: CBCharacteristic?
    private var carib_s_characteristic: CBCharacteristic?
    
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
        self.carib_f_characteristic = nil
        self.carib_s_characteristic = nil
        self.brightness_characteristic = nil
        self.deviceName = "デバイス未接続"
        bleState = .DISCONNECTED
    }
    
    //scanで端末が見つかると、呼ばれるコールバック
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        
    if let manufacturerData = advertisementData[CBAdvertisementDataManufacturerDataKey] as? Data {
                print("Manufacturer Data: \(manufacturerData.hexEncodedString())")
            }
        let localName = advertisementData[CBAdvertisementDataLocalNameKey]
//        print("Peripheralデバイスを発見しました: \(peripheral.name ?? "名前不明") - RSSI: \(RSSI) Local Name - \(localName ?? "null")")
        
        if localName != nil {
            let device_name = localName as! String
            if(!notTargetDevices.contains(device_name)){
                self.peripheral = peripheral
                centralManager?.connect(peripheral, options: nil)
                central.stopScan()
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Peripheralデバイスと接続しました: \(peripheral.name ?? "名前不明")")
        peripheral.delegate = self
        peripheral.discoverServices([
            CBUUID(string: "180A"),
            CBUUID(string: Constants.SERVICE_UUID)
        ])
    }
    
//    func peripheralDidUpdateName(_ peripheral: CBPeripheral){
//        print(\(peripheral.))
//    }
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
        
        var targetServiceCount = 0
        
        for service in services {
            print("サービス UUID: \(service.uuid)")
            // check version name
            
            // check device name
            if service.uuid == CBUUID(string: "180A") {
                print("180A")
                targetServiceCount += 1
                peripheral.discoverCharacteristics(nil, for: service)
            }
            if service.uuid == CBUUID(string: Constants.SERVICE_UUID) {
                targetServiceCount += 1
                print("サービスが見つかりました。目的のデバイスです。")
                peripheral.discoverCharacteristics(nil, for: service)
            }
            print("\(targetServiceCount)")
            if targetServiceCount >= 2 {
                
                return
            }
        }
        
        print(#function, "目的のサービスが見つかりません。")
        if (peripheral.name != nil) {
            notTargetDevices.append(peripheral.name!)
        }
        
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
        
        if service.uuid == CBUUID(string: "180A") {
            for characteristic in characteristics {
                if characteristic.uuid == CBUUID(string: "2A26") {
                    peripheral.readValue(for: characteristic)
                }
            }
        }
        if service.uuid == CBUUID(string: Constants.SERVICE_UUID) {
            for characteristic in characteristics {
                if characteristic.uuid == CBUUID(string: Constants.CHARACTERISTIC_UUID_F) {
                    peripheral.setNotifyValue(true, for: characteristic)
                }
                if characteristic.uuid == CBUUID(string: Constants.CHARACTERISTIC_UUID_S) {
                    peripheral.setNotifyValue(true, for: characteristic)
                }
                if characteristic.uuid == CBUUID(string: Constants.CHARACTERISTIC_UUID_BRIGHTNESS) {
                    print("brightness found chara")
                    self.brightness_characteristic = characteristic
                    peripheral.readValue(for: characteristic)
                }
                if characteristic.uuid == CBUUID(string: Constants.CHARACTERISTIC_UUID_F_CARIB) {
                    self.carib_f_characteristic = characteristic
                    peripheral.readValue(for: characteristic)
                }
                if characteristic.uuid == CBUUID(string: Constants.CHARACTERISTIC_UUID_S_CARIB) {
                    self.carib_s_characteristic = characteristic
                    peripheral.readValue(for: characteristic)
                }
            }
            
            print("connected device name \(peripheral.name ?? "")")
            bleState = .CONNECTED
        }
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
        
        if characteristic.uuid == CBUUID(string: Constants.CHARACTERISTIC_UUID_F) {
            guard let value: Float = floatFromData(data) else {
                return
            }
            print("\(value)")
            if (!value.isNaN) {
                self.temp_f = value
            } else {
                self.temp_f = 0.0
            }
            
        }
        if characteristic.uuid == CBUUID(string: Constants.CHARACTERISTIC_UUID_S) {
            guard let value: Float = floatFromData(data) else {
                return
            }
            if (!value.isNaN) {
                self.temp_s = value
            } else {
                self.temp_s = 0.0
            }
        }
        
        if characteristic.uuid == CBUUID(string: "2A26") {
            if let version = String(data: data, encoding: .utf8) {
                //                print("\(name) device name")
                self.deviceName = "\(peripheral.name ?? "") - v\(version)"
            }
        }
        
        if characteristic.uuid == CBUUID(string: Constants.CHARACTERISTIC_UUID_BRIGHTNESS) {
            if let data = characteristic.value, data.count >= 1 {
                let value = data[0]
                print("UInt8: \(value)")
                sliderVal = Int(value)
            }
        }
        
        if characteristic.uuid == CBUUID(string: Constants.CHARACTERISTIC_UUID_F_CARIB) {
            if let data = characteristic.value, data.count >= 1 {
                let int8Value = Int8(bitPattern: data[0])
                calibration_f = Double(Float(Int(int8Value)) / 10)
            }
        }
        
        if characteristic.uuid == CBUUID(string: Constants.CHARACTERISTIC_UUID_S_CARIB) {
            if let data = characteristic.value, data.count >= 1 {
                let int8Value = Int8(bitPattern: data[0])
                calibration_s = Double(Float(Int(int8Value)) / 10)
            }
        }
        
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("Write failed: \(error)")
        } else {
            print("Write success!")
            
            if characteristic.uuid == CBUUID(string: Constants.CHARACTERISTIC_UUID_BRIGHTNESS) {
                if (self.brightness_characteristic != nil) {
                    peripheral.readValue(for: self.brightness_characteristic!)
                }
            }
            
            if characteristic.uuid == CBUUID(string: Constants.CHARACTERISTIC_UUID_F_CARIB) {
                if (self.carib_f_characteristic != nil) {
                    peripheral.readValue(for: self.carib_f_characteristic!)
                }
                
            }
            
            if characteristic.uuid == CBUUID(string: Constants.CHARACTERISTIC_UUID_S_CARIB) {
                if (self.carib_s_characteristic != nil) {
                    peripheral.readValue(for: self.carib_s_characteristic!)
                }
            }
        }
    }
    
    func writeData(emitValue: Int, type: BLE_WIRTE_TYPE) {
        if (carib_f_characteristic == nil || carib_s_characteristic == nil || brightness_characteristic == nil) {
            print("characteristic nil")
            return } else {
            print("characteristic exist")
        }
        if (peripheral != nil) {
            switch type {
            case .TEMP_F:
                let data: Data = withUnsafeBytes(of: emitValue) { Data($0) }
                peripheral?.writeValue(data, for: carib_f_characteristic!, type: .withResponse)
            case .TEMP_S:
                let data: Data = withUnsafeBytes(of: emitValue) { Data($0) }
                peripheral?.writeValue(data, for: carib_s_characteristic!, type: .withResponse)
            case .BRIGHTNESS:
//                print("write brightness")
                let data: Data = withUnsafeBytes(of: emitValue) { Data($0) }
                if brightness_characteristic!.properties.contains(.write) {
                    // 書き込み可能
                    peripheral?.writeValue(data, for: brightness_characteristic!, type: .withResponse)
                }
                
            }
        }
    }
    
    func floatFromData(_ data: Data) -> Float? {
        guard data.count >= 4 else { return nil }
        return data.withUnsafeBytes { rawBufferPointer in
            let ptr = rawBufferPointer.bindMemory(to: Float.self)
            // リトルエンディアン想定の場合
            return Float(bitPattern: ptr[0].bitPattern)
        }
    }
}

extension Data {
    func hexEncodedString() -> String {
        return map { String(format: "%02hhX", $0) }.joined()
    }
}
