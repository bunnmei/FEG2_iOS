//
//  EditBtns.swift
//  FEG2
//
//  Created by ishida fumiaki on 2025/09/06.
//

import SwiftUI
import CoreData

struct EditBtns: View {
    var profile: ProfileEntity
    @Binding var deleteState: ProfileDelete
    
    @AppStorage("bookmarkProfileId") private var profileId: String = ""
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        let isBookmarked: Bool = profileId == profile.objectID.uriRepresentation().absoluteString
        HStack {
            Spacer()
            VStack(spacing: 16){
                Button(action: {
                    deleteState = .DELETING
                    viewContext.delete(profile)
                    do {
                        try viewContext.save()
                        if isBookmarked {
                            profileId = ""
                        }
                    deleteState = .DELETED
                    
                   } catch {
                       print("削除エラー:", error)
                   }
                }) {
                    Image(systemName: "trash")
                        .foregroundStyle(.onMain)
                }
                .frame(width: 50, height: 50)
                .background(.main)
                .clipShape(Circle())
                
        
                Button(action: {
                    if profileId != profile.objectID.uriRepresentation().absoluteString {
                        profileId = profile.objectID.uriRepresentation().absoluteString
                    }
                }) {
                    Image(systemName: "bookmark.circle")
                        .foregroundStyle(isBookmarked ? .onDisAble :.onMain)
                }
                .frame(width: 50, height: 50)
                .background(isBookmarked ? .disAble : .main)
                .clipShape(Circle())
                
                    
                NavigationLink(
                    destination: LogEditScreen(profile: profile)) {
                    VStack{
                        Image(systemName: "pencil")
                            .foregroundStyle( .onMain)
                    }
                    .frame(width: 50, height: 50)
                    .background(.main)
                    .clipShape(Circle())
                }
                
                Spacer().frame(height: 16)
            }
            Spacer().frame(width: 16)
        }
                
    }
}
