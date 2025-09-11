//
//  ListScreen.swift
//  FEG2
//
//  Created by ishida fumiaki on 2025/09/04.
//

import SwiftUI

struct LogListScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \ProfileEntity.createAt, ascending: false)])
    var profiles: FetchedResults<ProfileEntity>
    var body: some View {
            VStack(spacing: 0) {
                NavigationStack {
                    ScrollView {
                        VStack(spacing: 16) {
                            Spacer()
                            ForEach(profiles) { profile in
                                NavigationLink{
                                    LogDetailScreen(profile: profile)
                                } label: {
                                    ProfileCard(
                                        title: profile.name!,
                                        desc: profile.desc!,
                                        date: profile.createAt!,
                                        id: profile.objectID.uriRepresentation().absoluteString
                                    )
                                }
                            }
                            Spacer().frame(height: 50)
                        }.frame(maxWidth: Constants.maxWidth)
                    }
//                    .background(.green)
                }
            }
        
    }
}
