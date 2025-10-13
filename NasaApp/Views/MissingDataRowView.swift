//
//  MissingDataRowView.swift
//  NasaApp
//
//  Created by Olibo moni on 13/10/2025.
//


import SwiftUI

struct MissingDataRowView: View {
    let date: String

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "photo.fill")
                .font(.largeTitle)
                .foregroundColor(.secondary)
                .frame(width: 80, height: 80)
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text(date)
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text("Data not available for this day.")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    MissingDataRowView(date: "2025-10-13")
        .padding()
}
