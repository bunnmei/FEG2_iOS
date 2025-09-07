//
//  ChartScreen.swift
//  FEG2
//
//  Created by ishida fumiaki on 2025/09/04.
//

import SwiftUI

struct ChartScreen: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @EnvironmentObject var chartState: ChartState
    @State var scrollOffset: CGFloat = 0
    @AppStorage("bookmarkProfileId") private var profileId: String = ""
    
    @State var temp_f_list_w: [Float] = []
    @State var temp_s_list_w: [Float] = []
    
    var body: some View {
        TabHide(
        content: {
            ZStack{
                Chart(
                    temp_f_list: $chartState.temp_f_list,
                    temp_s_list: $chartState.temp_s_list,
                    temp_f_list_watermark: $temp_f_list_w,
                    temp_s_list_watermark: $temp_s_list_w,
                    scrollOffset: $scrollOffset
                )
                TempMemory()
                StatusPanel()
            }
        },
        tabOnContent: {
            MinuteMemory(scrollOffset: $scrollOffset)
            OperationBtn()
        })
        .onChange(of: profileId) {
            temp_f_list_w.removeAll()
            temp_s_list_w.removeAll()
            fetchData()
        }
        .onAppear {
            print("chart Screen onAppear")
            fetchData()
        }
        
    }
    
    private func fetchData() {
        guard let url = URL(string: profileId) else { return }
        guard let objId = viewContext.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: url)
        else { return  }
        
        do {
            let profile = try viewContext.existingObject(with: objId) as? ProfileEntity
            
            if let chartEntities = profile?.charts as? Set<ChartEntity> {
                let sortedChartEntities = chartEntities.sorted { $0.point_index < $1.point_index }
                print("sortedCharts count: \(sortedChartEntities.count)")
                sortedChartEntities.forEach { (chartEntity) in
                    let (temp_f, temp_s) = Constants.unpackTemp(packed: chartEntity.temp)
                    print("unpack encoded \(Constants.decodeTemp(encoded: temp_f))")
                    temp_f_list_w.append(Constants.decodeTemp(encoded: temp_f))
                    temp_s_list_w.append(Constants.decodeTemp(encoded: temp_s))
                }
            }
        } catch {
            print("db fetch error")
        }
    }
}
