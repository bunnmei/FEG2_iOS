//
//  ContentView.swift
//  FEG2
//
//  Created by ishida fumiaki on 2025/09/04.
//

import SwiftUI
import CoreData

class TabOffset: ObservableObject {
    @Published var tabOffset: CGFloat = 0
}

class MinuteMemoryScroll: ObservableObject {
    @Published var scrollOffset: CGFloat = 0
}

class CurrentScreen: ObservableObject {
    @Published var targetScreen: Bool = false
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var currentTab: BottomNavItem = .settings
    
    @StateObject var tabOffset: TabOffset = TabOffset()
//    @StateObject var minuteMemoryScroll = MinuteMemoryScroll()
//    @StateObject var minuteMemoryScroll_LogDetailScreen = MinuteMemoryScroll()
    @StateObject var logDetailScreen: CurrentScreen = CurrentScreen()
    
    @AppStorage("screenMode") var screenMode: String = ScreenMode.system.rawValue
    var color : ColorScheme? {
        switch screenMode {
            case ScreenMode.system.rawValue:
                return nil
            case ScreenMode.light.rawValue:
                return .light
            case ScreenMode.dark.rawValue:
                return .dark
            default:
                return nil
        }
    }
    
    var body: some View {
        
        CustomTab(
            currentTab: $currentTab,
            tabOffset: $tabOffset.tabOffset,
            tabOnContent: {
//                if(currentTab == .graph) {
//                    ZStack(
//                        alignment: .bottom
//                    ) {
//                        MinuteMemory(scrollOffset: $minuteMemoryScroll.scrollOffset)
//                        OperationBtn()
//                    }.onTapGesture {
//                        print("taped tabOncontent")
//                    }
//                }
            }
        ){
            ZStack {
                
                LogListScreen()
                    .opacity(currentTab == .list ? 1 : 0)
                    .environmentObject(logDetailScreen)
                
                ChartScreen()
                    .opacity(currentTab == .graph ? 1 : 0)
                
                SettingsScreen()
                    .opacity(currentTab == .settings ? 1 : 0)
            
            }
            .environmentObject(tabOffset)
            
            .onChange(of: currentTab){
                tabOffset.tabOffset = 0
            }
        }
        .background(.bg)
        .preferredColorScheme(color)
//        .environmentObject(minuteMemoryScroll)
//        .environmentObject(minuteMemoryScroll_LogDetailScreen)
        
        
    }
}
//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//}
//
//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()
//
//#Preview {
//    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}
