//
//  Trajectory.swift
//  BarebonesApp
//
//  Created by Bruno Cassani on 7/4/24.
//

import Foundation

class Trajectory {
    // Constants (default values, can be overridden)
    var L = 0.695                           // Length of arrow (nock throat to tip) (m)
    var W = 0.00092583                      // Width of the arrow (diameter) (m)
    var M = 0.023275768                     // Mass of the arrow (kg)
    var C = 0.23                            // Drag coefficient (unitless)
    var v0 = 81.3816                        // Initial velocity (m/s)
    var sightHeight = 0.0904748             // Sight height (meters)

    // Other constants
    let g = 9.80665                         // Gravitational acceleration (m/s^2)
    var rho: Double = 0.0                   // Density of air (kg/m^3)
    let pi = 3.14159265358979323846         // Pi (unitless)
    let tolerance: Double = 0.005 / 1.09361
    
    // Cross-sectional area (m^2)
    var A: Double {
        return L * W
    }

    init(){
        
    }
    // Constructor
    init(L: Double, W: Double, M: Double, C: Double, v0: Double, sightHeight: Double) {
        self.L = L
        self.W = W
        self.M = M
        self.C = C
        self.v0 = v0
        self.sightHeight = sightHeight
    }

    // Calculate air density function
    func calculateAirDensity(tempDew: Double, airPressure: Double, temp: Double) -> Double {
        // Convert inputs to appropriate units
        let airPressurePascals = airPressure * 1000  // Convert from kilopascals to pascals
        let tempKelvin = temp + 273.15                // Convert from Celsius to Kelvin

        // Constants
        let e = 2.718281828459045

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
        var y = sightHeight              // Initial height

        // Initial variables
        var x = 0.0
        var vx = v0 * cos(theta)
        var vy = v0 * sin(theta)

        // Simulation loop
        while y >= sightHeight {
            // Update velocity
            let v = sqrt(vx * vx + vy * vy)
            let F_drag = 0.5 * rho * A * C * v * v
            let ax = -F_drag * (vx / v) / M
            let ay = -g - F_drag * (vy / v) / M

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
        for targetDistance in stride(from: 20 / 1.09361, through: 120 / 1.09361, by: 1) {
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
