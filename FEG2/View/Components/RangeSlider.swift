//
//  RangeSlider.swift
//  FEG2
//
//  Created by ishida fumiaki on 2025/09/07.
//

import SwiftUI

struct RangeSlider: View {
//    @State var range = -200 ... -100
//    @State var range = -50 ... 50
//    @State var range = 0 ... 100
//    @State var range = 50 ... 150
//    @State var range = 0 ... 500
//    @State var pos_f:Float = 0.2
//    @State var pos_s:Float = 1.0
//    var step:Int = 50
    var range: ClosedRange<Int>
    @Binding var default_min: Int
    @Binding var default_max: Int
    var step: Int
    
    @State var pos_f:Float = 0.0
    @State var pos_s:Float = 1.0
    
    var body: some View {
        GeometryReader { geometry in
//            Text("min \(cVal(pos: pos_f)) max \(cVal(pos: pos_s))")
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.sub)
                    .frame(height: 4)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(2)
                
                HStack {
                    Spacer().frame(width: geometry.size.width * CGFloat(pos_f))
                    Rectangle()
                        .fill(.main)
                        .frame(height: 4)
                        .frame(width: geometry.size.width * (CGFloat(pos_s - pos_f)))
                        .cornerRadius(2)
                }
                
                Circle()
                    .fill(.white)
                    .frame(width: 28, height: 28)
                    .offset(x: (geometry.size.width - 28) * CGFloat(pos_f))
                    .shadow(color: .black.opacity(0.3), radius: 4, x: 2, y: 2)
                
                Circle()
                    .fill(.white)
                    .frame(width: 28, height: 28)
                    .offset(x: (geometry.size.width - 28) * CGFloat(pos_s))
                    .shadow(color: .black.opacity(0.3), radius: 4, x: 2, y: 2)
            }
            
//            .frame(maxWidth: .infinity)
//            .background(.gray.opacity(0.3))
            .gesture(
                DragGesture()
                   .onChanged { drag in
                       let newValue = Float(min(max(0, drag.location.x / geometry.size.width), 1))
                       let f = abs(pos_f-newValue)
                       let s = abs(pos_s-newValue)
                       let x10: Int = Int(Float(newValue) * Float(step))
                       let rou: Float = Float(x10) / Float(step)

                       if (f == s) {
                           if(rou < pos_f) {
                               if (rou < pos_s) {
                                   pos_f = rou
                               } else {
                                   pos_f = pos_s
                               }
                           } else {
                               if(rou > pos_f) {
                                   pos_s = rou
                               } else {
                                   pos_s = pos_f
                               }
                           }
                       } else if(f < s) {
                           if (rou <= pos_s) {
                               pos_f = rou
                           } else {
                               pos_f = pos_s
                           }
                       } else {
                           if(rou >= pos_f) {
                               pos_s = rou
                           } else {
                               pos_s = pos_f
                           }
                       }
                       default_min = cVal(pos: pos_f)
                       default_max = cVal(pos: pos_s)
//                       print("pf \(pos_f) ps \(pos_s)")
                   }
            ).onAppear{
//                print("onAppear")
                pos_f = cValParsent(defVal: default_min)
                pos_s = cValParsent(defVal: default_max)
            }
        }.frame(height: 28)
        
    }
       
    
    private func cVal(pos: Float) -> Int {
        let minVal = range.lowerBound >= 0 ? -range.lowerBound : abs(range.lowerBound)
        let totalValueWidth: Int = range.upperBound + minVal
        let ratio: Float = Float(totalValueWidth) * pos
        let silideToMin = Int(ratio) - minVal
        return silideToMin
    }
    
    private func cValParsent(defVal: Int) -> Float {
        let minVal = range.lowerBound >= 0 ? -range.lowerBound : abs(range.lowerBound)
        let totalValueWidth: Int = range.upperBound + minVal
        return Float (Float(defVal) / Float(totalValueWidth))
    }
//    private func cVulMax() -> String {
//        let totalValueWidth: Int = abs(range.upperBound) + abs(range.lowerBound)
//        let ratio: Float = Float(totalValueWidth) * pos_s
//        let silideToMax = Int(ratio) - abs(range.lowerBound)
//        return String(silideToMax)
//    }
}
