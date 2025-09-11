//
//  ChartState.swift
//  FEG2
//
//  Created by ishida fumiaki on 2025/09/05.
//

import SwiftUI

class ChartState: ObservableObject {
    
    private var db: PersistenceController
    init (db: PersistenceController) {
        self.db = db
    }
    
    @Published var temp_f_list: [Float] = []
    @Published var temp_s_list: [Float] = []
    @Published var data_keeped: DataKeep = .NODATA
    
    func add_temps(f: Float, s: Float) {
        if(data_keeped == .NODATA || data_keeped == .KEEPED) {
            data_keeped = .NOT_KEEPED
        }
        let rounded_f = Float(Int(Float(f*10))) / 10 //しも一桁にまるめる
        let rounded_s = Float(Int(Float(s*10))) / 10
//        print("rr \(rounded_f)")
        temp_f_list.append(rounded_f)
        temp_s_list.append(rounded_s)
        
    }
    
    func list_clear() {
        temp_f_list.removeAll()
        temp_s_list.removeAll()
        data_keeped = .NODATA
    }
    
    func keep_db() {
        if (data_keeped == .NOT_KEEPED) {
            data_keeped = .KEEPING
            Task { @MainActor in
                let copied_f_list = Array(temp_f_list)
                let copied_s_list = Array(temp_s_list)
                db.keepData(list_f: copied_f_list, list_s: copied_s_list)
                data_keeped = .KEEPED
            }
        }
        
    }
}

enum DataKeep {
    case KEEPED
    case NOT_KEEPED
    case KEEPING
    case NODATA
}
