//
//  Persistence.swift
//  FEG2
//
//  Created by ishida fumiaki on 2025/09/04.
//

import CoreData
import SwiftUI

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "FEG2")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    func keepData(list_f: [Float], list_s: [Float]) {
        let newProfile = ProfileEntity(context: context)
        newProfile.name = ""
        newProfile.desc = ""
        newProfile.createAt = Date()
        
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
        
        list_f.enumerated().forEach { intex, value in
            let temp_f_encoded = Constants.encodeTemp(temp: value)
            let temp_s_encoded = Constants.encodeTemp(temp: list_s[intex])
            let newChart = ChartEntity(context: context)
            newChart.profile = newProfile
            newChart.point_index = Int16(intex)
            newChart.temp = Constants.packTemp(temp_f: temp_f_encoded, temp_s: temp_s_encoded)
        }
        
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

//extension ProfileEntity {
//    var chartArray: [ChartEntity] {
//        let set = charts as? Set<ChartEntity> ?? []
//        return set.sorted { $0.point_index < $1.point_index }
//    }
//}
