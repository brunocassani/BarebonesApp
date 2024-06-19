//
//  ContentView.swift
//  BarebonesApp
//
//  Created by Bruno Cassani on 6/11/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var climateData = ClimateData()
    @StateObject private var bowData = BowData()
    @StateObject private var sightData = SightData()
    @StateObject private var arrowData = ArrowData()
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Section(header: Text("Climate").font(.headline)) {
                    Group {
                        TextField("Temperature (F)", value: $climateData.temperature, formatter: formatter) .keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding()
                        TextField("Humidity (%)", value: $climateData.humidity, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding()
                        TextField("Pressure (inHg)", value: $climateData.pressure, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding()
                        TextField("Additional Temperature (F)", value: $climateData.dew, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding()
                    }
                }
                
                Section(header: Text("Bow").font(.headline)) {
                    Group {
                        TextField("Peep to Arrow (in)", value: $bowData.peepToArrow, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding()
                        TextField("Peep to Pin (in)", value: $bowData.peepToPin, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding()
                    }
                }
                
                Section(header: Text("Sight").font(.headline)) {
                    Group {
                        TextField("Range 1 (yds)", value: $sightData.range1, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding()
                        TextField("Mark 1 (marks)", value: $sightData.mark1, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding()
                        TextField("Range 2 (yds)", value: $sightData.range2, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding()
                        TextField("Mark 2 (marks)", value: $sightData.mark2, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding()
                        TextField("Distance Between 1 and 2 (in)", value: $sightData.distanceBetween1And2, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding()
                    }
                }
                
                Section(header: Text("Arrow").font(.headline)) {
                    Group {
                        TextField("Speed (fps)", value: $arrowData.speed, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding()
                        TextField("Weight (grains)", value: $arrowData.weight, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding()
                        TextField("Diameter (in)", value: $arrowData.diameter, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding()
                        TextField("Length (in)", value: $arrowData.length, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding()
                        TextField("FOC (%)", value: $arrowData.foc, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding()
                    }
                }
            }
            .padding()
        }
    }
}
