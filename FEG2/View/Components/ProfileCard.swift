//
//  ProfileCard.swift
//  FEG2
//
//  Created by ishida fumiaki on 2025/09/05.
//

import SwiftUI
import CoreData

struct ProfileCard: View {
    var title: String
    var desc: String
    var date: Date
    var id: String
    
    @AppStorage("bookmarkProfileId") private var profileId: String = ""
    let screenSize = UIScreen.main.bounds
    var body: some View {
        let isBookmark: Bool = profileId == id ? true : false
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Spacer().frame(width: 16)
                    Text(title == "" ? "No Name" : title)
                        .font(.system(size: 24, weight: .medium))
                        .foregroundStyle(.onBg)
                       
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Image(systemName: "bookmark.fill")
                            .foregroundStyle(isBookmark ? .onMain : .onDisAble)
                    }
                    .frame(width: 50, height: 50)
                    .background(isBookmark ? .main : .disAble)
                    .simultaneousGesture(
                        LongPressGesture(minimumDuration: 1.0) // 秒数指定
                            .onEnded { _ in
                                if (isBookmark) {
                                    profileId = ""
                                }
                            }
                    )
                }.frame(height: 50)
                VStack(spacing: 0){
                    Text(desc == "" ? "No Description" : desc)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                        .lineSpacing(8)
                    Spacer()
                }
                .frame(maxHeight: .infinity, alignment: .center)
                .padding([.leading, .trailing], 16)
                HStack {
                    Spacer()
                    Text("\(dateFormatter.string(from: date))")
                        .foregroundStyle(.onBg)
                    Spacer().frame(width: 16)
                }.frame(height: 50)
                
            }
            .frame(width: screenSize.width-32, height: (screenSize.width-32) * (9 / 16))  //16:9
            .background(.card)
            .cornerRadius(16)
        }
        .padding([.leading, .trailing], 16)
        
    }
    
    private let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
       formatter.dateStyle = .short
       formatter.timeStyle = .medium
       return formatter
    }()
}
//______________
//|             |
//| moziretu    |
//| moziretu    |
//| moziretu    |
//|             |
//|_____________|
//
//_VStack{

//}
//
