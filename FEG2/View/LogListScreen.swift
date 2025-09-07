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
    
    
    let screenSize = UIScreen.main.bounds
    var body: some View {
            VStack(spacing: 0) {
                NavigationStack {
                    ScrollView {
                        VStack(spacing: 16) {
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
                        }
                    }
//                    .background(.green)
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}
