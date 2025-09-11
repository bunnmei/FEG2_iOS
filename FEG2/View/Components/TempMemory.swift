//
//  TempMemory.swift
//  FEG2
//
//  Created by ishida fumiaki on 2025/09/04.
//

import SwiftUI

struct TempMemory: View {
    
    @AppStorage("temp_min") private var bottomTemp = 0
    @AppStorage("temp_max") private var topTemp = 200
//    @State var topTemp: Int = 200
//    @State var bottomTemp: Int = 0
   
    var body: some View {
        GeometryReader { geometry in
            let range = topTemp-bottomTemp
            let oneMemoryHeight = getOneMemoryHeight(height: Float(geometry.size.height), range: range)
            Canvas { context, size in
                for n in 0...(range/10) {
                    let m_y = oneMemoryHeight * Float(n)
                    
                    let m_path = Path { path in
                        path.move(to: CGPoint(x: 0, y: CGFloat(m_y)))
                        path.addLine(to: CGPoint(x: 10, y: CGFloat(m_y)))
                    }
                    
                    context.stroke(m_path, with: .color(.main))
                    
                    if (n == 0 || n == (range/10) || (topTemp-n*10)%50 != 0) {
                        continue
                    }
//                        memo text
                    let text = String(format:"%02d", topTemp - n*10)
                    let font = Font.system(size: 10)
                    let resolved = context.resolve(Text(text).font(font).foregroundStyle(.main))
                    context.draw(resolved, at: CGPoint(x: 20, y: Int(m_y)))
                }
            }.frame(width:Constants.memoryWidth, height:geometry.size.height)
//                .background(.pink)
        }
      
        .allowsHitTesting(false)
    }
    
    func getOneMemoryHeight(height:Float, range:Int) -> Float {
        let oneMem = height / (Float(range)/10)
        return oneMem
    }
}
