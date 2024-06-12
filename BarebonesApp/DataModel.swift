//
//  DataModel.swift
//  BarebonesApp
//
//  Created by Bruno Cassani on 6/11/24.
//

import Foundation

struct ClimateData {
    var temperature1: String = ""
    var humidity: String = ""
    var pressure: String = ""
    var temperature2: String = ""
}

struct BowData {
    var peepToArrow: String = ""
    var peepToPin: String = ""
}

struct SightData {
    var range1: String = ""
    var mark1: String = ""
    var range2: String = ""
    var mark2: String = ""
    var distanceBetween1And2: String = ""
}

struct ArrowData {
    var speed: String = ""
    var weight: String = ""
    var diameter: String = ""
    var length: String = ""
    var foc: String = ""
}
