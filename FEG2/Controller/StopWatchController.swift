//
//  StopWatchController.swift
//  FEG2
//
//  Created by ishida fumiaki on 2025/09/04.
//

import SwiftUI
import Foundation

enum StopWatchState {
    case STOPED //初期状態、リセットあと
    case STARTED
    case PAUSED
}

class StopWatchController: ObservableObject {
    
    private var bleController: BluetoothLEController
    private var chartState: ChartState
    
    init(
        bleController: BluetoothLEController,
        chartState: ChartState
    ) {
        self.bleController = bleController
        self.chartState = chartState
    }
    
    @Published var timeString: String = "00:00.00"
    @Published var StopWatchState: StopWatchState = .STOPED

    private var timer: Timer?
    private var isRunning: Bool = false
    private var startTime: Date?
    private var accumulatedTime: TimeInterval = 0
    private var seconds: Int = 0
    
    func stopOrStart(resetFlug: Bool = false){
        switch StopWatchState {
        case .STOPED: if(!resetFlug) {start()}
        case .STARTED: if(!resetFlug) {pause()}
            case .PAUSED:
                if resetFlug {
                    reset()
                } else {
                    resume()
                }
        }
    }
    
    private func start() {
        StopWatchState = .STARTED
        startTime = Date()
        
        timer = Timer.scheduledTimer(
            withTimeInterval: 0.01,
            repeats: true) { [weak self] _ in
                self?.updateTime()
            }
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    private func pause() {
        guard timer != nil else { return }
        StopWatchState = .PAUSED
        timer?.invalidate()
        timer = nil
        if let startData = startTime {
            accumulatedTime += Date().timeIntervalSince(startData)
        }
        self.startTime = nil
    }
    
    func resume() {
        guard timer == nil else { return }
        StopWatchState = .STARTED
        startTime = Date()
        timer = Timer.scheduledTimer(
            withTimeInterval: 0.01, repeats: true
        ) { [weak self] _ in
            self?.updateTime()
        }
        RunLoop.current.add(timer!, forMode: .common)
    }

    
    private func stop() {
        timer?.invalidate()
        accumulatedTime = 0
        timer = nil
        seconds = 0
    }

    private func reset() {
        stop()
        timeString = "00:00.00"
        StopWatchState = .STOPED
    }
    
    private func updateTime() {
//           guard let startDate = startTime else { return }
//           let elapsed = Date().timeIntervalSince(startDate)

            let elapsed: TimeInterval
                if let startDate = startTime {
                    elapsed = accumulatedTime + Date().timeIntervalSince(startDate)
                } else {
                    elapsed = accumulatedTime
                }
           let minutes = Int(elapsed) / 60
           let seconds = Int(elapsed) % 60
           let centiseconds = Int((elapsed - floor(elapsed)) * 100)
        
            if (self.seconds < Int(elapsed)) {
                
                self.seconds = Int(elapsed)
                //  一秒ごとに実行する処理
                chartState.add_temps(f: bleController.temp_f, s: bleController.temp_s)
                print("length \(chartState.temp_f_list.count)")
                if(self.seconds >= 1800) {
                    self.pause()
                    chartState.keep_db()
                }
            }

           timeString = String(format: "%02d:%02d.%02d", minutes, seconds, centiseconds)
       }
}
