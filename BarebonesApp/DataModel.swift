//
//  DataModel.swift
//  BarebonesApp
//
//  Created by Bruno Cassani on 6/11/24.
//

import Foundation
import SwiftUI

class ClimateData: ObservableObject {
    @Published var temperature: Double = 0.0 //fahrenheit
    //@Published var humidity: Double = 0.0 //DEPRECATED, NOT NEEDED, SAME WITH ALTITUDE
    @Published var pressure: Double = 0.0 //inHg
    @Published var dew: Double = 0.0//fahrenheit
    
    var pressureKPA: Double {
        return pressure * 3.38639
    }
    
    var dewCelsius: Double {
        return (dew - 32) * (5 / 9)
        }
    
    var temperatureCelsius: Double {
        return (temperature - 32) * (5 / 9)
    }
}

class BowData: ObservableObject {
    @Published var peepToArrow: Double = 0.0
    @Published var peepToPin: Double = 0.0 //DEPRECATED, NOT NEEDED
    
    var peepToPinMeters: Double {
        return peepToPin * 0.0254
    }
}


/**
 * SIGHT DATA VALUES INPUTTED IN YARDS, OUTPUTTED IN METERS IF DESIRED
 */
class SightData: ObservableObject {
    @Published var range1: Double = 0.0
    @Published var mark1: Double = 0.0
    @Published var range2: Double = 0.0
    @Published var mark2: Double = 0.0
    @Published var minRange: Double = 20.0
    @Published var maxRange: Double = 80.0
    @Published var distanceBetween1And2: Double = 0.0
    
    
    var range1Meters: Double {
        return range1 * 0.9144
    }

    var range2Meters: Double {
        return range2 * 0.9144
    }

    var minRangeMeters: Double {
        return minRange * 0.9144
    }

    var maxRangeMeters: Double {
        return maxRange * 0.9144
    }

    var distanceBetween1And2Meters: Double {
        return distanceBetween1And2 * 0.9144
    }
    
}


class ArrowData: ObservableObject {
    @Published var speed: Double = 0.0 //fps -> mps
    @Published var weight: Double = 0.0 //grains -> kg
    @Published var diameter: Double = 0.0 //in -> m
    @Published var length: Double = 0.0 //in -> m
    @Published var foc: Double = 0.0 //deprecated, don't use
    
    var speedMPS: Double {
        return speed * 0.3048
    }

    var weightKg: Double {
        return weight * 0.00006479891
    }

    var diameterMeters: Double {
        return diameter * 0.0254
    }

    var lengthMeters: Double {
        return length * 0.0254
    }
}

extension NumberFormatter {
    static var decimal: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
}
