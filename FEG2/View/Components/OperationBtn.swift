//
//  OperationBtn.swift
//  FEG2
//
//  Created by ishida fumiaki on 2025/09/04.
//

import SwiftUI

struct OperationBtn: View {
    
    @State private var angle = Angle(degrees: 0.0)
    @State var buttonShow: Bool = false
    
    @EnvironmentObject var stopWatch: StopWatchController
    @EnvironmentObject var bleController: BluetoothLEController
    @EnvironmentObject var chatState: ChartState
    var body: some View {
        VStack(
            alignment: .leading
        ){
            HStack {
                VStack (spacing: 16){
                    Button(action: {
                        bleController.scanOrDissconect()
                    }){
                        switch bleController.bleState {
                            case .CONNECTED:
                            Bluetooth_Connected().frame(width:24, height:24)
                                .foregroundStyle(bleController.bluetooth_ON ? .onMain : .onDisAble)
                                .offset(x: 0, y: 24)
                            case .SCANNING:
                            Bluetooth_Search().frame(width:24, height:24)
                                .foregroundStyle(bleController.bluetooth_ON ? .onMain : .onMain)
                                .offset(x: 0, y: 24)
                            default:
                            Bluetooth().frame(width:24, height:24)
                                .foregroundStyle(bleController.bluetooth_ON ? .onMain : .onMain)
                                .offset(x: 0, y: 24)
                        }
                    }
                    .frame(width: 50, height: 50)
                    .background(bleController.bluetooth_ON ? .main : .disAble)
                    .clipShape(Circle())
                    .scaleEffect(buttonShow ? 1.0 : 0.0)
                    .animation(.easeInOut(duration: 0.15), value: buttonShow)
                    
                    Button(action: {
                        stopWatch.stopOrStart()
                    }){
                        if (stopWatch.StopWatchState == .STARTED) {
                            Image(systemName: "pause.fill")
                                .foregroundStyle(.onMain)
                        } else {
                            Image(systemName: "play.fill")
                                .foregroundStyle(.onMain)
                        }
                        
                    }
                    .frame(width: 50, height: 50)
                    .background(.main)
                    .clipShape(Circle())
                    .scaleEffect(buttonShow ? 1.0 : 0.0)
                    .animation(.easeInOut(duration: 0.15), value: buttonShow)
                    
                    Button(action: {
                        chatState.keep_db()
                    }){
                        Image(systemName: "arrow.down.to.line")
                            .foregroundStyle(
                                chatState.data_keeped == .NOT_KEEPED &&
                                stopWatch.StopWatchState == .PAUSED ?
                                    .onMain : .onDisAble)
                    }
                    .frame(width: 50, height: 50)
                    .background(
                        chatState.data_keeped == .NOT_KEEPED &&
                        stopWatch.StopWatchState == .PAUSED ?
                        .main : .disAble)
                    .clipShape(Circle())
                    .scaleEffect(buttonShow ? 1.0 : 0.0)
                    .animation(.easeInOut(duration: 0.15), value: buttonShow)
                    
                    Button(action: {
                        stopWatch.stopOrStart(resetFlug: true)
                        chatState.list_clear()
                    }){
                        Image(systemName: "arrow.trianglehead.clockwise.rotate.90")
                            .foregroundStyle(stopWatch.StopWatchState == .PAUSED ?
                                    .onMain : .onDisAble)
                    }
                    .frame(width: 50, height: 50)
                    .background(stopWatch.StopWatchState == .PAUSED ?
                        .main : .disAble)
                    .clipShape(Circle())
                    .scaleEffect(buttonShow ? 1.0 : 0.0)
                    .animation(.easeInOut(duration: 0.15), value: buttonShow)
                    
//                    arrow.down.to.line
                    Button(action: {
                        buttonShow.toggle()
                        if buttonShow {
                            angle = .degrees(45)
                        } else {
                            angle = .degrees(0)
                        }
                    }){
                        Image(systemName: "plus")
                            .foregroundColor(.onSub)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .clipShape(Rectangle())
                    .frame(width: 60, height: 60)
                    .background(.sub)
                    .cornerRadius(16)
                    .rotationEffect(angle)
                    .animation(.easeInOut(duration: 0.15), value: angle)
                    
                    
                }
                .padding([.leading, .bottom], 32)
                Spacer()
            }
            
        }
   }
}
