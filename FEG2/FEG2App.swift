//
//  FEG2App.swift
//  FEG2
//
//  Created by ishida fumiaki on 2025/09/04.
//

import SwiftUI

@main
struct FEG2App: App {
    let persistenceController:PersistenceController = PersistenceController.shared

    var bleController: BluetoothLEController = BluetoothLEController()
    var charState: ChartState
    var stopWatch: StopWatchController
    
    init() {
        self.charState = ChartState(db: persistenceController)
        self.stopWatch = StopWatchController(
            bleController: bleController,
            chartState: charState
        )
    }
    

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(stopWatch)
                .environmentObject(bleController)
                .environmentObject(charState)
        }
    }
}
