//
//  OperationBtnItem.swift
//  FEG2
//
//  Created by ishida fumiaki on 2025/09/04.
//

enum OperationBtnItem: String, CaseIterable {
    case bluetooth = "bluetooth"
    case play = "play"
    case keep = "keep"
    case clear = "clear"
    
    var icon: String? {
        switch self {
            case .bluetooth: return nil
            case .play: return "play.fill"
            case .keep: return "arrow.down.to.line"
            case .clear:return "arrow.trianglehead.clockwise.rotate.90"
        }
    }
}
