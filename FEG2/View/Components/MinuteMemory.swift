//
//  MinuteMemory.swift
//  FEG2
//
//  Created by ishida fumiaki on 2025/09/04.
//

import SwiftUI


struct MinuteMemory: View {
    @Binding var scrollOffset: CGFloat
    
    private let screenSize = UIScreen.main.bounds
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false){
                Canvas { context, size in
                    for n in 0...Int(Constants.maxMinute) {
                        
                        let m_x = CGFloat((CGFloat(n)+1)*Constants.oneMinute)
                        let m_path = Path { path in
                            path.move(to: CGPoint(x: m_x, y: size.height))
                            path.addLine(to: CGPoint(x: m_x, y: size.height-10))
                        }
                        
                        context.stroke(m_path, with: .color(.main))
                        
                        //                        memo text
                        let text = String(format:"%02d", n+1)
                        let font = Font.system(size: 10)
                        let resolved = context.resolve(Text(text).font(font).foregroundStyle(.main))
                        context.draw(resolved, at: CGPoint(x: m_x, y: size.height-20))
                    }
                }
                .frame(
                    width: CGFloat(Constants.oneMinute*30+60),
                    height: Constants.memoryWidth
                )
//                .background(.green.opacity(0.4))
                .offset(x: scrollOffset)
                .onChange(of: scrollOffset) {
                    print("\(scrollOffset) minute memory")
                }
            
        }
        .frame(height: 50)
//        .background(.yellow.opacity(0.3))
        .disabled(true)
        
    }
}
