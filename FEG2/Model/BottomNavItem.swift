//
//  BottomNavItem.swift
//  FEG2
//
//  Created by ishida fumiaki on 2025/09/04.
//

enum BottomNavItem: String, CaseIterable {
    case list = "list.bullet"
    case graph = "chart.xyaxis.line"
    case settings = "gear"
    
    var label: String {
        switch self {
            case .list: return "list.bullet"
            case .graph: return "graph"
            case .settings: return "settings"
        }
    }
}
