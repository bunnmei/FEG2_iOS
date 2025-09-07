//
//  BluetoothIcons.swift
//  FEG2
//
//  Created by ishida fumiaki on 2025/09/04.
//

import SwiftUI

struct Bluetooth: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.45833*width, y: -0.08333*height))
        path.addLine(to: CGPoint(x: 0.45833*width, y: -0.4*height))
        path.addLine(to: CGPoint(x: 0.26667*width, y: -0.20833*height))
        path.addLine(to: CGPoint(x: 0.20833*width, y: -0.26667*height))
        path.addLine(to: CGPoint(x: 0.44167*width, y: -0.5*height))
        path.addLine(to: CGPoint(x: 0.20833*width, y: -0.73333*height))
        path.addLine(to: CGPoint(x: 0.26667*width, y: -0.79167*height))
        path.addLine(to: CGPoint(x: 0.45833*width, y: -0.6*height))
        path.addLine(to: CGPoint(x: 0.45833*width, y: -0.91667*height))
        path.addLine(to: CGPoint(x: 0.5*width, y: -0.91667*height))
        path.addLine(to: CGPoint(x: 0.7375*width, y: -0.67917*height))
        path.addLine(to: CGPoint(x: 0.55833*width, y: -0.5*height))
        path.addLine(to: CGPoint(x: 0.7375*width, y: -0.32083*height))
        path.addLine(to: CGPoint(x: 0.5*width, y: -0.08333*height))
        path.addLine(to: CGPoint(x: 0.45833*width, y: -0.08333*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.54167*width, y: -0.6*height))
        path.addLine(to: CGPoint(x: 0.62083*width, y: -0.67917*height))
        path.addLine(to: CGPoint(x: 0.54167*width, y: -0.75625*height))
        path.addLine(to: CGPoint(x: 0.54167*width, y: -0.6*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.54167*width, y: -0.24375*height))
        path.addLine(to: CGPoint(x: 0.62083*width, y: -0.32083*height))
        path.addLine(to: CGPoint(x: 0.54167*width, y: -0.4*height))
        path.addLine(to: CGPoint(x: 0.54167*width, y: -0.24375*height))
        path.closeSubpath()
        return path
    }
}

struct Bluetooth_Search: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.375*width, y: -0.08333*height))
        path.addLine(to: CGPoint(x: 0.375*width, y: -0.4*height))
        path.addLine(to: CGPoint(x: 0.18333*width, y: -0.20833*height))
        path.addLine(to: CGPoint(x: 0.125*width, y: -0.26667*height))
        path.addLine(to: CGPoint(x: 0.35833*width, y: -0.5*height))
        path.addLine(to: CGPoint(x: 0.125*width, y: -0.73333*height))
        path.addLine(to: CGPoint(x: 0.18333*width, y: -0.79167*height))
        path.addLine(to: CGPoint(x: 0.375*width, y: -0.6*height))
        path.addLine(to: CGPoint(x: 0.375*width, y: -0.91667*height))
        path.addLine(to: CGPoint(x: 0.41667*width, y: -0.91667*height))
        path.addLine(to: CGPoint(x: 0.65417*width, y: -0.67917*height))
        path.addLine(to: CGPoint(x: 0.475*width, y: -0.5*height))
        path.addLine(to: CGPoint(x: 0.65417*width, y: -0.32083*height))
        path.addLine(to: CGPoint(x: 0.41667*width, y: -0.08333*height))
        path.addLine(to: CGPoint(x: 0.375*width, y: -0.08333*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.45833*width, y: -0.6*height))
        path.addLine(to: CGPoint(x: 0.5375*width, y: -0.67917*height))
        path.addLine(to: CGPoint(x: 0.45833*width, y: -0.75625*height))
        path.addLine(to: CGPoint(x: 0.45833*width, y: -0.6*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.45833*width, y: -0.24375*height))
        path.addLine(to: CGPoint(x: 0.5375*width, y: -0.32083*height))
        path.addLine(to: CGPoint(x: 0.45833*width, y: -0.4*height))
        path.addLine(to: CGPoint(x: 0.45833*width, y: -0.24375*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.68958*width, y: -0.40208*height))
        path.addLine(to: CGPoint(x: 0.59375*width, y: -0.5*height))
        path.addLine(to: CGPoint(x: 0.68958*width, y: -0.59583*height))
        path.addQuadCurve(to: CGPoint(x: 0.70469*width, y: -0.54896*height), control: CGPoint(x: 0.69896*width, y: -0.57292*height))
        path.addQuadCurve(to: CGPoint(x: 0.71042*width, y: -0.5*height), control: CGPoint(x: 0.71042*width, y: -0.525*height))
        path.addQuadCurve(to: CGPoint(x: 0.70469*width, y: -0.45052*height), control: CGPoint(x: 0.71042*width, y: -0.475*height))
        path.addQuadCurve(to: CGPoint(x: 0.68958*width, y: -0.40208*height), control: CGPoint(x: 0.69896*width, y: -0.42604*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.8125*width, y: -0.28333*height))
        path.addLine(to: CGPoint(x: 0.76042*width, y: -0.33333*height))
        path.addQuadCurve(to: CGPoint(x: 0.79271*width, y: -0.41406*height), control: CGPoint(x: 0.78125*width, y: -0.37188*height))
        path.addQuadCurve(to: CGPoint(x: 0.80417*width, y: -0.5*height), control: CGPoint(x: 0.80417*width, y: -0.45625*height))
        path.addQuadCurve(to: CGPoint(x: 0.79271*width, y: -0.58594*height), control: CGPoint(x: 0.80417*width, y: -0.54375*height))
        path.addQuadCurve(to: CGPoint(x: 0.76042*width, y: -0.66667*height), control: CGPoint(x: 0.78125*width, y: -0.62813*height))
        path.addLine(to: CGPoint(x: 0.8125*width, y: -0.71875*height))
        path.addQuadCurve(to: CGPoint(x: 0.85885*width, y: -0.61354*height), control: CGPoint(x: 0.84271*width, y: -0.66875*height))
        path.addQuadCurve(to: CGPoint(x: 0.875*width, y: -0.5*height), control: CGPoint(x: 0.875*width, y: -0.55833*height))
        path.addQuadCurve(to: CGPoint(x: 0.85885*width, y: -0.38698*height), control: CGPoint(x: 0.875*width, y: -0.44167*height))
        path.addQuadCurve(to: CGPoint(x: 0.8125*width, y: -0.28333*height), control: CGPoint(x: 0.84271*width, y: -0.33229*height))
        path.closeSubpath()
        return path
    }
}

struct Bluetooth_Connected: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.45833*width, y: -0.08333*height))
        path.addLine(to: CGPoint(x: 0.45833*width, y: -0.4*height))
        path.addLine(to: CGPoint(x: 0.26667*width, y: -0.20833*height))
        path.addLine(to: CGPoint(x: 0.20833*width, y: -0.26667*height))
        path.addLine(to: CGPoint(x: 0.44167*width, y: -0.5*height))
        path.addLine(to: CGPoint(x: 0.20833*width, y: -0.73333*height))
        path.addLine(to: CGPoint(x: 0.26667*width, y: -0.79167*height))
        path.addLine(to: CGPoint(x: 0.45833*width, y: -0.6*height))
        path.addLine(to: CGPoint(x: 0.45833*width, y: -0.91667*height))
        path.addLine(to: CGPoint(x: 0.5*width, y: -0.91667*height))
        path.addLine(to: CGPoint(x: 0.7375*width, y: -0.67917*height))
        path.addLine(to: CGPoint(x: 0.55833*width, y: -0.5*height))
        path.addLine(to: CGPoint(x: 0.7375*width, y: -0.32083*height))
        path.addLine(to: CGPoint(x: 0.5*width, y: -0.08333*height))
        path.addLine(to: CGPoint(x: 0.45833*width, y: -0.08333*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.54167*width, y: -0.6*height))
        path.addLine(to: CGPoint(x: 0.62083*width, y: -0.67917*height))
        path.addLine(to: CGPoint(x: 0.54167*width, y: -0.75625*height))
        path.addLine(to: CGPoint(x: 0.54167*width, y: -0.6*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.54167*width, y: -0.24375*height))
        path.addLine(to: CGPoint(x: 0.62083*width, y: -0.32083*height))
        path.addLine(to: CGPoint(x: 0.54167*width, y: -0.4*height))
        path.addLine(to: CGPoint(x: 0.54167*width, y: -0.24375*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.20833*width, y: -0.4375*height))
        path.addQuadCurve(to: CGPoint(x: 0.16406*width, y: -0.45573*height), control: CGPoint(x: 0.18229*width, y: -0.4375*height))
        path.addQuadCurve(to: CGPoint(x: 0.14583*width, y: -0.5*height), control: CGPoint(x: 0.14583*width, y: -0.47396*height))
        path.addQuadCurve(to: CGPoint(x: 0.16406*width, y: -0.54427*height), control: CGPoint(x: 0.14583*width, y: -0.52604*height))
        path.addQuadCurve(to: CGPoint(x: 0.20833*width, y: -0.5625*height), control: CGPoint(x: 0.18229*width, y: -0.5625*height))
        path.addQuadCurve(to: CGPoint(x: 0.2526*width, y: -0.54427*height), control: CGPoint(x: 0.23438*width, y: -0.5625*height))
        path.addQuadCurve(to: CGPoint(x: 0.27083*width, y: -0.5*height), control: CGPoint(x: 0.27083*width, y: -0.52604*height))
        path.addQuadCurve(to: CGPoint(x: 0.2526*width, y: -0.45573*height), control: CGPoint(x: 0.27083*width, y: -0.47396*height))
        path.addQuadCurve(to: CGPoint(x: 0.20833*width, y: -0.4375*height), control: CGPoint(x: 0.23438*width, y: -0.4375*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.79167*width, y: -0.4375*height))
        path.addQuadCurve(to: CGPoint(x: 0.7474*width, y: -0.45573*height), control: CGPoint(x: 0.76563*width, y: -0.4375*height))
        path.addQuadCurve(to: CGPoint(x: 0.72917*width, y: -0.5*height), control: CGPoint(x: 0.72917*width, y: -0.47396*height))
        path.addQuadCurve(to: CGPoint(x: 0.7474*width, y: -0.54427*height), control: CGPoint(x: 0.72917*width, y: -0.52604*height))
        path.addQuadCurve(to: CGPoint(x: 0.79167*width, y: -0.5625*height), control: CGPoint(x: 0.76563*width, y: -0.5625*height))
        path.addQuadCurve(to: CGPoint(x: 0.83594*width, y: -0.54427*height), control: CGPoint(x: 0.81771*width, y: -0.5625*height))
        path.addQuadCurve(to: CGPoint(x: 0.85417*width, y: -0.5*height), control: CGPoint(x: 0.85417*width, y: -0.52604*height))
        path.addQuadCurve(to: CGPoint(x: 0.83594*width, y: -0.45573*height), control: CGPoint(x: 0.85417*width, y: -0.47396*height))
        path.addQuadCurve(to: CGPoint(x: 0.79167*width, y: -0.4375*height), control: CGPoint(x: 0.81771*width, y: -0.4375*height))
        path.closeSubpath()
        return path
    }
}

