//
//  NasaAppApp.swift
//  NasaApp
//
//  Created by Olibo moni on 12/10/2025.
//

import SwiftUI

@main
struct NasaAppApp: App {
    init(){
        configureURLCache()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    private func configureURLCache() {
           // Define cache capacities: 50MB in memory, 200MB on disk.
           let memoryCapacity = 50 * 1024 * 1024
           let diskCapacity = 200 * 1024 * 1024
           
           // Create the URLCache instance.
           let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "photo_cache")
           
           // Set the custom cache for the shared URLSession.
           URLCache.shared = cache
       }
    
}
