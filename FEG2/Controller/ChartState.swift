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
    @Published var data_keeped = true
    
    func add_temps(f: Float, s: Float) {
        if(data_keeped) {
            data_keeped = false
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
    }
    
    func keep_db() {
        if (!data_keeped) {
            db.keepData(list_f: temp_f_list, list_s: temp_s_list)
            data_keeped = true
        }
        
    }
}
