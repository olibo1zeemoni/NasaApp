//
//  ContentView.swift
//  NasaApp
//
//  Created by Olibo moni on 12/10/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       PhotoListView()
    }
    
    private func getBatteryLevel() {
           let device = UIDevice.current
           // Battery monitoring must be enabled.
           device.isBatteryMonitoringEnabled = true
           
           // Check if the battery level is available.
           if device.batteryState == .unknown {
               // If the state is unknown, send an error.
               print("UNAVAILABLE : Battery level not available.")
           } else {
               
               print("\(Int(device.batteryLevel * 100))%")
           }
       }
}

#Preview {
    ContentView()
}
