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
                        VStack(alignment: .leading) {
                            Text("Temperature (F)")
                            TextField("Temperature (F)", value: $climateData.temperature, formatter: formatter) .keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                        VStack(alignment: .leading) {
                            Text("Humidity (%)")
                            TextField("Humidity (%)", value: $climateData.humidity, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                        VStack(alignment: .leading) {
                            Text("Pressure (inHg)")
                            TextField("Pressure (inHg)", value: $climateData.pressure, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                        VStack(alignment: .leading) {
                            Text("Additional Temperature (F)")
                            TextField("Additional Temperature (F)", value: $climateData.dew, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                    }
                }
                
                Section(header: Text("Bow").font(.headline)) {
                    Group {
                        VStack(alignment: .leading) {
                            Text("Peep to Arrow (in)")
                            TextField("Peep to Arrow (in)", value: $bowData.peepToArrow, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                        VStack(alignment: .leading) {
                            Text("Peep to Pin (in)")
                            TextField("Peep to Pin (in)", value: $bowData.peepToPin, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                    }
                }
                
                Section(header: Text("Sight").font(.headline)) {
                    Group {
                        VStack(alignment: .leading) {
                            Text("Range 1 (yds)")
                            TextField("Range 1 (yds)", value: $sightData.range1, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                        VStack(alignment: .leading) {
                            Text("Mark 1 (marks)")
                            TextField("Mark 1 (marks)", value: $sightData.mark1, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                        VStack(alignment: .leading) {
                            Text("Range 2 (yds)")
                            TextField("Range 2 (yds)", value: $sightData.range2, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                        VStack(alignment: .leading) {
                            Text("Mark 2 (marks)")
                            TextField("Mark 2 (marks)", value: $sightData.mark2, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                        VStack(alignment: .leading) {
                            Text("Distance Between 1 and 2 (in)")
                            TextField("Distance Between 1 and 2 (in)", value: $sightData.distanceBetween1And2, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                    }
                }
                
                Section(header: Text("Arrow").font(.headline)) {
                    Group {
                        VStack(alignment: .leading) {
                            Text("Speed (fps)")
                            TextField("Speed (fps)", value: $arrowData.speed, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                        VStack(alignment: .leading) {
                            Text("Weight (grains)")
                            TextField("Weight (grains)", value: $arrowData.weight, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                        VStack(alignment: .leading) {
                            Text("Diameter (in)")
                            TextField("Diameter (in)", value: $arrowData.diameter, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                        VStack(alignment: .leading) {
                            Text("Length (in)")
                            TextField("Length (in)", value: $arrowData.length, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                        VStack(alignment: .leading) {
                            Text("FOC (%)")
                            TextField("FOC (%)", value: $arrowData.foc, formatter: formatter).keyboardType(.numberPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
