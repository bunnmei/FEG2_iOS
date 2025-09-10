//
//  SettingTextField.swift
//  FEG2
//
//  Created by ishida fumiaki on 2025/09/10.
//
import SwiftUI

struct SettingTextField : View {
    @FocusState.Binding var focused: Bool
    var type: BLE_WIRTE_TYPE
    
    @State var carib: Double = 0.0
    @EnvironmentObject var bleController: BluetoothLEController
    
    var body: some View {
        HStack {
            TextField(value: $carib, format: .number) {
                Text("-5.0 ~ 5.0 の数値を入力")
            }
            .keyboardType(.numbersAndPunctuation)
            .onChange(of: carib) {
                carib = Swift.min(Swift.max(carib, -5.0), 5.0)
            }
            .tint(.main)
            .focused($focused)
            .padding(16)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(focused ? .main : Color.gray, lineWidth: focused ? 3 : 1)
            )
            Spacer().frame(width: 16)
            Button(action: {
                print("emit ble write")
                bleController.writeData(emitValue: Int(Double(carib*10)), type: self.type)
            }) {
                Image(systemName: "paperplane.fill")
                    .foregroundStyle(.onMain)
            }
            .frame(width: 50, height: 50)
            .background(.main)
            .clipShape(Circle())
            .disabled(bleController.bleState != .CONNECTED)
            .opacity(bleController.bleState == .CONNECTED ? 1.0 : 0.4)
        }
    }
}
