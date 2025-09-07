//
//  TabHide.swift
//  FEG2
//
//  Created by ishida fumiaki on 2025/09/04.
//

import SwiftUI

struct TabHide<Content: View, TabOnContent: View,>: View {
    
    var content: Content
    var tabOnContent: TabOnContent
    
    init(
        @ViewBuilder content: () -> Content,
        @ViewBuilder tabOnContent: () -> TabOnContent
    ) {
        self.content = content()
        self.tabOnContent = tabOnContent()
    }
    
    @EnvironmentObject var tabOffset: TabOffset
    
    var body: some View {
        GeometryReader {proxy in
            ZStack {
                content
                .onTapGesture {
                    print("tab hide ontaped")
                    if (tabOffset.tabOffset == 0) {
                        tabOffset.tabOffset = 50 + proxy.safeAreaInsets.bottom
                    } else {
                        tabOffset.tabOffset = 0
                    }
                    
                }
                
                VStack {
                    Spacer()
                   
                    ZStack(alignment: .bottom) {
                        tabOnContent
                    }
        
                    Spacer()
                        .frame(height: tabOffset.tabOffset >= 50 ? 0: tabOffset.tabOffset + 50)

                }
            }.animation(.easeInOut(duration: 0.2), value: tabOffset.tabOffset)
        }
    }
}
