//
//  Untitled.swift
//  FEG2
//
//  Created by ishida fumiaki on 2025/09/07.
//

import SwiftUI

struct SettingPanel<Content: View>: View {
    var divider:Bool
    var desc: String
    var content: Content
    init(
        divider:Bool = true,
        desc: String,
        @ViewBuilder content: () -> Content,
    ) {
        self.divider = divider
        self.desc = desc
        self.content = content()
    }
    var body: some View {
        VStack {
            if divider {
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 1)
                    .edgesIgnoringSafeArea(.horizontal)
                    .padding([.bottom], 16)
            }
            HStack{
                Text(desc)
                    .font(.system(size: 14))
                Spacer()
            }
//            Spacer().frame(height: 24)
            content
        }
//        .background(.yellow.opacity(0.3))
    }
}
