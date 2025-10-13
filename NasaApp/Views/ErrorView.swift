//
//  ErrorView.swift
//  NasaApp
//
//  Created by Olibo moni on 13/10/2025.
//

import SwiftUI

struct ErrorView: View {
    let errorMessage: String
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.largeTitle)
                .foregroundColor(.red)
            Text("An Error Occurred")
                .font(.headline)
            Text(errorMessage)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

#Preview {
    ErrorView(errorMessage: "The URL provided was invalid")
}
