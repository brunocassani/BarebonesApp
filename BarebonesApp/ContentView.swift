//
//  ContentView.swift
//  BarebonesApp
//
//  Created by Bruno Cassani on 6/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var climateData = ClimateData()
    @State private var bowData = BowData()
    @State private var sightData = SightData()
    @State private var arrowData = ArrowData()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Climate Data Inputs
                Group {
                    Text("CLIMATE").font(.headline)
                    TextField("Temperature (F)", text: $climateData.temperature1)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    TextField("Humidity (%)", text: $climateData.humidity)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    TextField("Pressure (inHg)", text: $climateData.pressure)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    TextField("Temperature (F)", text: $climateData.temperature2)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                
                // Bow Data Inputs
                Group {
                    Text("BOW").font(.headline)
                    TextField("Peep to Arrow (in)", text: $bowData.peepToArrow)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    TextField("Peep to Pin (in)", text: $bowData.peepToPin)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                
                // Sight Data Inputs
                Group {
                    Text("SIGHT").font(.headline)
                    TextField("Range 1 (yds)", text: $sightData.range1)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    TextField("Mark 1 (marks)", text: $sightData.mark1)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    TextField("Range 2 (yds)", text: $sightData.range2)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    TextField("Mark 2 (marks)", text: $sightData.mark2)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    TextField("Distance between 1 and 2 (in)", text: $sightData.distanceBetween1And2)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                
                // Arrow Data Inputs
                Group {
                    Text("ARROW").font(.headline)
                    TextField("Speed (fps)", text: $arrowData.speed)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    TextField("Weight (grains)", text: $arrowData.weight)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    TextField("Diameter (in)", text: $arrowData.diameter)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    TextField("Length (in)", text: $arrowData.length)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    TextField("FOC (%)", text: $arrowData.foc)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
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
