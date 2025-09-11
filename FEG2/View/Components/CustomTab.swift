//
//  CustomeTap.swift
//  FEG2
//
//  Created by ishida fumiaki on 2025/09/04.
//
import SwiftUI

struct CustomTab<Content: View>: View {
    @Binding var currentTab: BottomNavItem
    @Binding var tabOffset: CGFloat
    var content: Content
    
    init(
        currentTab: Binding<BottomNavItem>,
        tabOffset: Binding<CGFloat>,
        @ViewBuilder content: () -> Content
    ){
        self._tabOffset = tabOffset
        self._currentTab = currentTab
        self.content = content()
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            let safeArea = CGSize(
                width: geometry.size.width,
                height: geometry.size.height
            )
            ZStack {
                VStack{
                    content
                }
                .frame(width: safeArea.width, height: safeArea.height)
                .contentShape(Rectangle())
                
                // tab UI
                VStack{
                    Spacer()
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            ForEach(BottomNavItem.allCases, id: \.self){ item in
                                VStack(spacing: 0) {
                                    VStack(spacing: 0) {
                                        Image(systemName: item.rawValue)
                                            .foregroundStyle(.onSub)
                                    }.frame(width: 70, height: 35) //bottom tab icon 
                                        .background(currentTab == item ? .sub : .bgSub)
                                        .cornerRadius(17.5)
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .onTapGesture {
                                    currentTab = item
                                }
                                
                            }
                        }
                        .frame(width: safeArea.width, height: 50)
                        .background(.bgSub)
                        .offset(y: tabOffset)
                    }
                }.animation(.easeInOut(duration: 0.2), value: tabOffset)
                
            }
        }
        
    }
}
