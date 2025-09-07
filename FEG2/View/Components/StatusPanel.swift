//
//  StatusPanel.swift
//  FEG2
//
//  Created by ishida fumiaki on 2025/09/04.
//

import SwiftUI

struct StatusPanel: View {
    
    @EnvironmentObject var stopWatch: StopWatchController
    @EnvironmentObject var bleController :BluetoothLEController
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 0) {
                HStack{
                    Spacer()
                    Text(stopWatch.timeString)
                        .font(.system(size: 60, design: .monospaced))
                        .tracking(-3)
                        .italic()
                        .fontWeight(.light)
                        .frame(height: 80, alignment: .trailing)
                        .fixedSize(horizontal: true, vertical: false)
                        .foregroundStyle(.gray)
                    Spacer().frame(width: 16)
                }
                HStack{
                    Spacer()
                    Text(String(format: "%.1f", bleController.temp_f))
                        .font(.system(size: 60, design: .monospaced))
                        .tracking(-3)
                        .italic()
                        .fontWeight(.light)
                        .frame(height: 80, alignment: .trailing)
                        .fixedSize(horizontal: true, vertical: false)
                        .foregroundStyle(.chartF)
                    Spacer().frame(width: 16)
                }
                
                HStack{
                    Spacer()
                    Text(String(format: "%.1f", bleController.temp_s))
                        .font(.system(size: 60, design: .monospaced))
                        .tracking(-3)  
                        .italic()
                        .fontWeight(.light)
                        .frame(height: 80, alignment: .trailing)
                        .fixedSize(horizontal: true, vertical: false)
                        .foregroundStyle(.chartS)
                    Spacer().frame(width: 16)
                }
                Spacer()
                
            }
        }
        
        
    }
}
