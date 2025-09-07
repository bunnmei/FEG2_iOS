//
//  SettingsScreen.swift
//  FEG2
//
//  Created by ishida fumiaki on 2025/09/04.
//

import SwiftUI

enum ScreenMode: String, CaseIterable {
    case system = "system"
    case light = "light"
    case dark = "dark"
}


struct SettingsScreen: View {
    
    @AppStorage("temp_min") private var min = 0
    @AppStorage("temp_max") private var max = 200
    @AppStorage("screenMode") var screenMode: String = ScreenMode.system.rawValue

    @State var sliderVal = 2
    
    @State var carib_f: String = ""
    @State var carib_s: String = ""
    @FocusState private var focused: Bool
    @FocusState private var focused2: Bool
    
    var screenSize = UIScreen.main.bounds
    
    var body: some View {
        ScrollView{
            VStack {
                HStack {
                    Text("設定")
                        .font(.system(size: 32))
                    Spacer()
                }
                
                SettingPanel(desc: "グラフの温度 最低温度:\(min) 最高温度:\(max)") {
                    Spacer().frame(height: 16)
                    RangeSlider(
                        range: 0 ... 500,
                        default_min: $min,
                        default_max: $max,
                        step: 50
                    )
                    Spacer().frame(height: 24)
                }

                SettingPanel(desc: "テーマ") {
                    HStack{
                        Text("システム")
                        Spacer()
                        if(screenMode == ScreenMode.system.rawValue) {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.main)
                        }
                    }
                    .frame(height: 70)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        screenMode = ScreenMode.system.rawValue
                    }
    //                .background(.pink.opacity(0.2))
                    HStack{
                        Text("ダーク")
                        Spacer()
                        if(screenMode == ScreenMode.dark.rawValue) {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.main)
                        }
                    }
                    .frame(height: 70)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        screenMode = ScreenMode.dark.rawValue
                    }
    //                    .background(.pink.opacity(0.2))
                    HStack{
                        Text("ライト")
                        Spacer()
                        if(screenMode == ScreenMode.light.rawValue) {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.main)
                        }
                    }
                    .frame(height: 70)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        screenMode = ScreenMode.light.rawValue
                    }
    //                .background(.pink.opacity(0.2))
                }
                
                SettingPanel(desc: "BLEデバイス") {
                    HStack{
                        Text("BLE Addr XX:XX:XX:XX:XX:XX:")
                        Spacer()
                    }.frame(height: 70)
                }
                
                SettingPanel(desc: "7セグの明るさ:\(sliderVal)") {
                    Slider(value: Binding(
                        get: { Double(sliderVal) }, // Int を Double に変換
                        set: { sliderVal = Int($0)}
                    ), in: 0...8, step: 1)
                    .tint(.main)
//                    .foregroundStyle(.main)
                }
                
                SettingPanel(desc: "温度-1 キャリブレーション:0.0") {
                    HStack {
                        TextField(text: $carib_f) {
                            Text("-5.0 ~ 5.0 の数値を入力")
                        }
                        .tint(.main)
                        .focused($focused)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(focused ? .main : Color.gray, lineWidth: focused ? 3 : 1)
                        )
                        Spacer().frame(width: 16)
                        Button(action: {
                            
                        }) {
                            Image(systemName: "paperplane.fill")
                                .foregroundStyle(.onMain)
                        }
                        .frame(width: 50, height: 50)
                        .background(.main)
                        .clipShape(Circle())
                    }
                }
                
                SettingPanel(desc: "温度-2 キャリブレーション:0.0") {
                    HStack {
                        TextField(text: $carib_s) {
                            Text("-5.0 ~ 5.0 の数値を入力")
                        }
                        .tint(.main)
                        .focused($focused2)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(focused2 ? .main : Color.gray, lineWidth: focused2 ? 3 : 1)
                        )
                        Spacer().frame(width: 16)
                        Button(action: {
                            
                        }) {
                            Image(systemName: "paperplane.fill")
                                .foregroundStyle(.onMain)
                        }
                        .frame(width: 50, height: 50)
                        .background(.main)
                        .clipShape(Circle())
                    }
                }
                
                Spacer().frame(height: 50+16)
                Spacer()
            }.padding([.leading, .trailing, .top], 16)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .background(Color.clear)
        .onTapGesture {
            focused = false
            focused2 = false
        }
    }
}
