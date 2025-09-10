//
//  Constants.swift
//  FEG2
//
//  Created by ishida fumiaki on 2025/09/04.
//

import SwiftUI

enum Constants {
    static let tabHeight = 50
    static let oneMinute: CGFloat = 120
    static let memoryWidth: CGFloat = 50
    static let maxMinute: CGFloat = 30
    static let SERVICE_UUID = "811b864d-718c-b035-804d-92c4761243c0"
    static let CHARACTERISTIC_UUID_F = "0601a001-0eca-b5ab-edc2-887fd5f32b84"
    static let CHARACTERISTIC_UUID_S = "620321e5-17c6-ca12-8328-7db87b02fbe5"
    static let CHARACTERISTIC_UUID_BRIGHTNESS = "8a959d93-3d42-0c75-eaa3-3b37f5275fff"
    static let CHARACTERISTIC_UUID_F_CARIB = "324010a6-eede-268f-8c88-c5632308eb41"
    static let CHARACTERISTIC_UUID_S_CARIB = "04525bfa-46e2-3540-1174-afaba112e062"
    
    static func encodeTemp(temp: Float) -> Int {
        let scaled = Int(Float(temp * 10))
        return scaled + 2000
    }
    
    static func decodeTemp(encoded: Int) -> Float {
        return Float(Float(encoded - 2000) / 10)
    }
    
    static func packTemp(temp_f: Int, temp_s: Int) -> Int32 {
        return Int32((temp_f << 14) | temp_s)
    }
    
    static func unpackTemp(packed: Int32) -> (Int, Int) {
        let temp_f = Int(packed >> 14)
        let temp_s = Int(packed & 0x3fff)
        return (temp_f, temp_s)
    }
}
