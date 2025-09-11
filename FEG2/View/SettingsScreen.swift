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
    
    @FocusState private var focused: Bool
    @FocusState private var focused2: Bool
    
    @EnvironmentObject var bleController: BluetoothLEController
    
    var screenSize = UIScreen.main.bounds
    
    var body: some View {
        ScrollViewReader { proxy in
        
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
                
                
//                
                SettingPanel(desc: "7セグの明るさ:\(sliderVal)") {
                    Slider(value: Binding(
                        get: { Double(sliderVal) }, // Int を Double に変換
                        set: { sliderVal = Int($0)}
                    ),
                    in: 0...8,
                    step: 1,
                    onEditingChanged: { editing in  // 指を離して操作が完了したタイミング
                       if !editing {
                           bleController.writeData(emitValue: sliderVal, type: .BRIGHTNESS)
                           print("変更が完了: \(sliderVal)")
                       }
                    })
                    .tint(.main)
                    .disabled(bleController.bleState != .CONNECTED)
                }
                
                SettingPanel(desc: "温度-1 キャリブレーション:0.0") {
                    SettingTextField(focused: $focused,type: .TEMP_F)
                }
                Spacer().frame(height: 16)
                SettingPanel(desc: "温度-2 キャリブレーション:0.0") {
                    SettingTextField(focused: $focused2, type: .TEMP_S)
                }

                Spacer().frame(height: 50+16)
                Spacer()
                    .id("BOTTOM")
            }
            .padding([.leading, .trailing, .top], 16)
            
        }
        .frame(maxWidth: Constants.maxWidth, maxHeight: .infinity)
        .contentShape(Rectangle())
        .background(Color.clear)
        .onTapGesture {
            focused = false
            focused2 = false
        }
        .onChange(of: [focused, focused2]) {
            if(focused || focused2) {
                withAnimation{
                    proxy.scrollTo("BOTTOM", anchor: .bottom)
                }
            }
        }
            
        }
    }
}
