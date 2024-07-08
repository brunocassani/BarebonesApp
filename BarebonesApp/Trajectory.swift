//
//  Trajectory.swift
//  BarebonesApp
//
//  Created by Bruno Cassani on 7/4/24.
//

import Foundation

class Trajectory {
    
    var climate: ClimateData
    var arrow: ArrowData
    var bow: BowData
    var sight: SightData
    
    // Other constants
    var C = 0.23                            // Drag coefficient (unitless)
    let g = 9.80665                         // Gravitational acceleration (m/s^2)
    var rho: Double = 0.0                   // Density of air (kg/m^3)
    let pi = 3.14159265358979323846         // Pi (unitless)
    let tolerance: Double = 0.005 / 1.09361
    
    // Cross-sectional area (m^2)
    var A: Double {
        return arrow.lengthMeters * arrow.diameterMeters
    }

    init(climate: ClimateData, arrow: ArrowData, bow: BowData, sight: SightData){
        self.climate = climate
        self.arrow = arrow
        self.bow = bow
        self.sight = sight
        
    }

    // Calculate air density function
    func calculateAirDensity(tempDew: Double, airPressure: Double, temp: Double) -> Double {
        // Convert inputs to appropriate units
        let airPressurePascals = climate.pressureKPA * 1000  // Convert from kilopascals to pascals
        let tempKelvin = climate.temperatureCelsius + 273.15                // Convert from Celsius to Kelvin

        // Calculations
        let vaporPressure = 611 * exp((17.27 * tempDew) / (237.3 + tempDew))  // Pascals
        let specificHumidity = 0.622 * (vaporPressure / airPressurePascals)   // (kg water) / (kg moist air)
        let ra = 287 * (1 + 0.608 * specificHumidity)
        let airDensity = airPressurePascals / (ra * tempKelvin)               // kg/m^3

        return airDensity
    }

    // Find x position function
    func find_x_position(thetaDeg: Double) -> Double {
        let theta = thetaDeg * pi / 180  // Launch angle in radians
        var y = bow.peepToPinMeters              // Initial height

        // Initial variables
        var x = 0.0
        var vx = arrow.speedMPS * cos(theta)
        var vy = arrow.speedMPS * sin(theta)

        // Simulation loop
        while y >= bow.peepToPinMeters {
            // Update velocity
            let v = sqrt(vx * vx + vy * vy)
            let F_drag = 0.5 * rho * A * C * v * v
            let ax = -F_drag * (vx / v) / arrow.weightKg
            let ay = -g - F_drag * (vy / v) / arrow.weightKg

            // Update momentum
            vx += ax * tolerance
            vy += ay * tolerance

            // Update position
            x += vx * tolerance
            y += vy * tolerance
        }

        // Return the x-position where the y-position is back to sightHeight
        return x
    }

    // Find angles function (stores angles in a 2D array)
    func findAngles() -> [[Double]] {
        var angles: [[Double]] = []

        // Iterate over the target x_distances in increments of 1 yard (converted to meters)
        for targetDistance in stride(from: sight.minRange / 1.09361, through: sight.maxRange / 1.09361, by: 1) {
            var thetaLow = 0.0
            var thetaHigh = 20.0
            var thetaMid = 0.0
            var xDistance = 0.0
            var foundAngle = false

            while thetaHigh - thetaLow > 0.00001 {
                thetaMid = (thetaLow + thetaHigh) / 2
                xDistance = find_x_position(thetaDeg: thetaMid)
                if abs(xDistance - targetDistance) < tolerance {
                    if angles.count <= Int(targetDistance) {
                        angles.append([])
                    }
                    angles[Int(targetDistance)].append(thetaMid)
                    foundAngle = true
                    break
                } else if xDistance < targetDistance {
                    thetaLow = thetaMid
                } else {
                    thetaHigh = thetaMid
                }
            }

            // Handle case where no theta was found
            if !foundAngle {
                angles.append([])
            }
        }

        return angles
    }
}
