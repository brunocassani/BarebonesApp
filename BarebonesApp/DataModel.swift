//
//  DataModel.swift
//  BarebonesApp
//
//  Created by Bruno Cassani on 6/11/24.
//

import Foundation
import SwiftUI

class ClimateData: ObservableObject {
    @Published var temperature: Double = 0.0
    @Published var humidity: Double = 0.0
    @Published var pressure: Double = 0.0
    @Published var dew: Double = 0.0
}

class BowData: ObservableObject {
    @Published var peepToArrow: Double = 0.0
    @Published var peepToPin: Double = 0.0
}

class SightData: ObservableObject {
    @Published var range1: Double = 0.0
    @Published var mark1: Double = 0.0
    @Published var range2: Double = 0.0
    @Published var mark2: Double = 0.0
    @Published var distanceBetween1And2: Double = 0.0
}

class ArrowData: ObservableObject {
    @Published var speed: Double = 0.0
    @Published var weight: Double = 0.0
    @Published var diameter: Double = 0.0
    @Published var length: Double = 0.0
    @Published var foc: Double = 0.0
}

extension NumberFormatter {
    static var decimal: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
}
