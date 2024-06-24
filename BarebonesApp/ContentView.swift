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
    
    @State private var navigateToPDFView = false
    
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
                            TextField("Temperature (F)", value: $climateData.temperature, formatter: formatter) .keyboardType(.decimalPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                        VStack(alignment: .leading) {
                            Text("Humidity (%)")
                            TextField("Humidity (%)", value: $climateData.humidity, formatter: formatter).keyboardType(.decimalPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                        VStack(alignment: .leading) {
                            Text("Pressure (inHg)")
                            TextField("Pressure (inHg)", value: $climateData.pressure, formatter: formatter).keyboardType(.decimalPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                        VStack(alignment: .leading) {
                            Text("Additional Temperature (F)")
                            TextField("Additional Temperature (F)", value: $climateData.dew, formatter: formatter).keyboardType(.decimalPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                    }
                }
                
                Section(header: Text("Bow").font(.headline)) {
                    Group {
                        VStack(alignment: .leading) {
                            Text("Peep to Arrow (in)")
                            TextField("Peep to Arrow (in)", value: $bowData.peepToArrow, formatter: formatter).keyboardType(.decimalPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                        VStack(alignment: .leading) {
                            Text("Peep to Pin (in)")
                            TextField("Peep to Pin (in)", value: $bowData.peepToPin, formatter: formatter).keyboardType(.decimalPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                    }
                }
                
                Section(header: Text("Sight").font(.headline)) {
                    Group {
                        VStack(alignment: .leading) {
                            Text("Range 1 (yds)")
                            TextField("Range 1 (yds)", value: $sightData.range1, formatter: formatter).keyboardType(.decimalPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                        VStack(alignment: .leading) {
                            Text("Mark 1 (marks)")
                            TextField("Mark 1 (marks)", value: $sightData.mark1, formatter: formatter).keyboardType(.decimalPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                        VStack(alignment: .leading) {
                            Text("Range 2 (yds)")
                            TextField("Range 2 (yds)", value: $sightData.range2, formatter: formatter).keyboardType(.decimalPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                        VStack(alignment: .leading) {
                            Text("Mark 2 (marks)")
                            TextField("Mark 2 (marks)", value: $sightData.mark2, formatter: formatter).keyboardType(.decimalPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                        VStack(alignment: .leading) {
                            Text("Distance Between 1 and 2 (in)")
                            TextField("Distance Between 1 and 2 (in)", value: $sightData.distanceBetween1And2, formatter: formatter).keyboardType(.decimalPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                    }
                }
                
                Section(header: Text("Arrow").font(.headline)) {
                    Group {
                        VStack(alignment: .leading) {
                            Text("Speed (fps)")
                            TextField("Speed (fps)", value: $arrowData.speed, formatter: formatter).keyboardType(.decimalPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                        VStack(alignment: .leading) {
                            Text("Weight (grains)")
                            TextField("Weight (grains)", value: $arrowData.weight, formatter: formatter).keyboardType(.decimalPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                        VStack(alignment: .leading) {
                            Text("Diameter (in)")
                            TextField("Diameter (in)", value: $arrowData.diameter, formatter: formatter).keyboardType(.decimalPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                        VStack(alignment: .leading) {
                            Text("Length (in)")
                            TextField("Length (in)", value: $arrowData.length, formatter: formatter).keyboardType(.decimalPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                        VStack(alignment: .leading) {
                            Text("FOC (%)")
                            TextField("FOC (%)", value: $arrowData.foc, formatter: formatter).keyboardType(.decimalPad).textFieldStyle(.roundedBorder).padding(.top, 5)
                        }
                    }
                }
                
                Button(action: {
                    // Save data to UserDefaults
                    UserDefaults.standard.set(climateData.temperature, forKey: "temperature")
                    UserDefaults.standard.set(climateData.humidity, forKey: "humidity")
                    UserDefaults.standard.set(climateData.pressure, forKey: "pressure")
                    UserDefaults.standard.set(climateData.dew, forKey: "dew")

                    UserDefaults.standard.set(bowData.peepToArrow, forKey: "peepToArrow")
                    UserDefaults.standard.set(bowData.peepToPin, forKey: "peepToPin")

                    UserDefaults.standard.set(sightData.range1, forKey: "range1")
                    UserDefaults.standard.set(sightData.mark1, forKey: "mark1")
                    UserDefaults.standard.set(sightData.range2, forKey: "range2")
                    UserDefaults.standard.set(sightData.mark2, forKey: "mark2")
                    UserDefaults.standard.set(sightData.distanceBetween1And2, forKey: "distanceBetween1And2")

                    UserDefaults.standard.set(arrowData.speed, forKey: "speed")
                    UserDefaults.standard.set(arrowData.weight, forKey: "weight")
                    UserDefaults.standard.set(arrowData.diameter, forKey: "diameter")
                    UserDefaults.standard.set(arrowData.length, forKey: "length")
                    UserDefaults.standard.set(arrowData.foc, forKey: "foc")

                    // Navigate to PDFView
                    navigateToPDFView = true
                }) {
                    Text("DONE")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }
                .background(
                    NavigationLink(destination: PDFView(), isActive: $navigateToPDFView) {
                        EmptyView()
                    }
                )

                
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
