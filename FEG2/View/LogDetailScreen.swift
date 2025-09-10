//
//  LogDetailScreen.swift
//  FEG2
//
//  Created by ishida fumiaki on 2025/09/05.
//

import SwiftUI
import CoreData

enum ProfileDelete {
   case NOTDELETE
   case DELETING
   case DELETED
}

struct LogDetailScreen: View {
    let profile: ProfileEntity
    
    @State var temp_f_list: [Float] = []
    @State var temp_s_list: [Float] = []
    
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("tempMaxVal") var sliderMaxVal: Int = 250
    
    @State var deleteState : ProfileDelete = .NOTDELETE
    @State var scrollOffset: CGFloat = 0
    
    let screenSize = UIScreen.main.bounds
    var body: some View {
        if(deleteState != .NOTDELETE) {
            VStack {
                if deleteState == .DELETED {
                    Text("削除完了")
                        .onAppear {
                            Task{
                                try? await Task.sleep(nanoseconds: 1_000_000_000)
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                } else {
                    Text("削除中")
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
        } else {
            ZStack {
                TabHide(
                    content: {
                        ZStack {
                            Chart(
                                temp_f_list: $temp_f_list,
                                temp_s_list: $temp_s_list,
                                temp_f_list_watermark: .constant([]),
                                temp_s_list_watermark: .constant([]),
                                scrollOffset: $scrollOffset
                            )
                            TempMemory()
                        }
                    }, tabOnContent: {
                        MinuteMemory(scrollOffset: $scrollOffset)
                        EditBtns(profile: profile, deleteState: $deleteState)
                    })
                
                VStack {
                    HStack(spacing: 4) {
                        Spacer().frame(width: 4)
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundStyle(.main)
                        Text("Back")
                            .foregroundStyle(.main)
                        Spacer()
                    }
                    .frame(width: screenSize.width, height: 50)
                    .background(.clear)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        print("back taped")
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                }
                
            }
            .navigationBarBackButtonHidden(true)
            .onAppear {
                if let chartEntities = profile.charts as? Set<ChartEntity> {
                    let sortedChartEntities = chartEntities.sorted { $0.point_index < $1.point_index }
                    print("sortedCharts count: \(sortedChartEntities.count)")
                    sortedChartEntities.forEach { (chartEntity) in
                        let (temp_f, temp_s) = Constants.unpackTemp(packed: chartEntity.temp)
                        print("unpack encoded \(Constants.decodeTemp(encoded: temp_f))")
                        temp_f_list.append(Constants.decodeTemp(encoded: temp_f))
                        temp_s_list.append(Constants.decodeTemp(encoded: temp_s))
                    }
                }
            }
            .onDisappear {
                temp_f_list.removeAll()
                temp_s_list.removeAll()
            }
            
        }
    }
}
