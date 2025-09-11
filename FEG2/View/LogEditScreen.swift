//
//  LogEditScreen.swift
//  FEG2
//
//  Created by ishida fumiaki on 2025/09/06.
//

import SwiftUI



struct LogEditScreen: View {
    var profile: ProfileEntity
    
    @State var title: String = ""
    @State var desc: String = ""
    @FocusState private var focused: Bool
    @FocusState private var focused2: Bool

    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    let screenSize = UIScreen.main.bounds
    
    var body: some View {
        ScrollView {
            
      
        VStack {
            VStack {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundStyle(.main)
                    Text("Back")
                        .foregroundStyle(.main)
                    Spacer()
                }
                .frame(height: 50)
                .background(.clear)
                .contentShape(Rectangle())
                .onTapGesture {
                        print("back taped")
                        presentationMode.wrappedValue.dismiss()
                }
    
                HStack {
                    Text("編集")
                        .font(.system(size: 32))
                    Spacer()
                }
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 1)
                    .edgesIgnoringSafeArea(.horizontal)
                    .padding([.bottom], 16)
                
                TextField(text: $title) {
                    Text("Profile Title")
                }
                .padding(16)
                .tint(.main)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(focused ? .main : Color.gray, lineWidth: focused ? 3 : 1) // 枠線の色と太さを指定
                )
                .onChange(of: title) {
                    profile.name = title
                    try? viewContext.save()
                }
                .focused($focused)
                .padding([.bottom], 16)
                
                TextEditor(text: $desc)
                .onChange(of: desc) {
                    profile.desc = desc
                    try? viewContext.save()
                }
                .frame(height: 84, alignment: .topLeading)
                .tint(.main)
                .padding(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(focused2 ? .main : Color.gray, lineWidth: focused2 ? 3 : 1) //
                )
                .focused($focused2)
                .padding([.bottom], 32)
                
                HStack {
                    Text("プレビュー")
                        .font(.system(size: 32))
                    Spacer()
                }
                
                
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 1)
                    .edgesIgnoringSafeArea(.horizontal)
                    .padding([.bottom], 16)
            }.padding([.leading, .trailing], 16)
            
            ProfileCard(
                title: title,
                desc: desc,
                date: Date(),
                id: ""
            )
            Spacer().frame(height: 50)
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: Constants.maxWidth, maxHeight: .infinity, alignment: .top)
        .contentShape(Rectangle())
        .background(Color.clear)
        .onTapGesture {
            focused = false
            focused2 = false
        }
        .onAppear{
            title = profile.name!
            desc = profile.desc!
        }
            
    
        }
    }
}
