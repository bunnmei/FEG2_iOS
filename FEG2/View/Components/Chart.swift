//
//  Chart.swift
//  FEG2
//
//  Created by ishida fumiaki on 2025/09/04.
//

import SwiftUI

struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

struct Chart: View {
    @Binding var temp_f_list: [Float]
    @Binding var temp_s_list: [Float]
    @Binding var temp_f_list_watermark: [Float]
    @Binding var temp_s_list_watermark: [Float]
    @Binding var scrollOffset: CGFloat
    
    @AppStorage("temp_min") private var bottomTemp = 0
    @AppStorage("temp_max") private var topTemp = 200
    
    var body : some View {
        GeometryReader { geometry in
            let range = topTemp - bottomTemp
            let oneTemp = geometry.size.height / CGFloat(range)
            ScrollView(.horizontal, showsIndicators: true) {
                Canvas { context, size in
                    drawChart(
                        in: context, size: size, oneTemp: oneTemp,
                        temp_f_list: temp_f_list, temp_s_list: temp_s_list
                    )
                    drawChart(
                        in: context, size: size, oneTemp: oneTemp,
                        temp_f_list: temp_f_list_watermark, temp_s_list: temp_s_list_watermark,
                        opaci: 0.5
                    )
                }.frame(
                    width: CGFloat(Constants.oneMinute*Constants.maxMinute + (Constants.oneMinute/2)),
                    height: geometry.size.height
                )
                .background(GeometryReader {
                    Color.clear.preference(
                        key: OffsetPreferenceKey.self,
                        value: $0.frame(in: .global).origin.x
                    )
                })
            }.onPreferenceChange(OffsetPreferenceKey.self) { offset in
                scrollOffset = offset
            }
        }
    }
    
    private func drawChart(
        in context: GraphicsContext, size: CGSize, oneTemp: CGFloat,
        temp_f_list: [Float], temp_s_list: [Float] , opaci: Double = 1.0
    ) {
        
        for (i, _) in temp_f_list.enumerated() {
            if(temp_f_list.count < 2 &&
               temp_s_list.count < 2) {return}
            if (i >= 1) {
                let temp_y:Float = temp_f_list[i]-Float(bottomTemp)
                let temp_y_prev:Float = temp_f_list[i-1]-Float(bottomTemp)
                let temp_y_s = temp_s_list[i]-Float(bottomTemp)
                let temp_y_prev_s = temp_s_list[i-1]-Float(bottomTemp)
                
                let y = size.height - CGFloat(Float(oneTemp) * temp_y)
                let y_p = size.height - CGFloat(Float(oneTemp) * temp_y_prev)
                
                let y_s = size.height - CGFloat(Float(oneTemp) * temp_y_s)
                let y_p_s = size.height - CGFloat(Float(oneTemp) * temp_y_prev_s)
                let path = Path { path in
                    let m: CGPoint = CGPoint(x: Double((i-1)*2), y: Double(y_p))
                    let n: CGPoint = CGPoint(x: Double((i)*2), y: Double(y))
                    path.move(to: m)
                    path.addLine(to: n)
                }
                
                let path_s = Path { path in
                    let m: CGPoint = CGPoint(x: Double((i-1)*2), y: Double(y_p_s))
                    let n: CGPoint = CGPoint(x: Double(i*2), y: Double(y_s))
                    path.move(to: m)
                    path.addLine(to: n)
                }
                context.stroke(path_s, with: .color(.chartS.opacity(opaci)))
                context.stroke(path, with: .color(.chartF.opacity(opaci)))
                
            }
        }
        
    }
}
