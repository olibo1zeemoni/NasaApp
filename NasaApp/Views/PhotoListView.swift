//
//  PhotoListView.swift
//  NasaApp
//
//  Created by Olibo moni on 12/10/2025.
//


import SwiftUI
import SwiftData

struct PhotoListView: View {
    @StateObject private var photoInfoVM = PhotoInfoViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if photoInfoVM.isLoading && photoInfoVM.photoInfos.isEmpty {
                    ProgressView("Fetching Photos...")
                } else if let errorMessage = photoInfoVM.errorMessage {
                   ErrorView(errorMessage: errorMessage)
                } else {
                    List($photoInfoVM.photoInfos) { $photoInfo in
                        PhotoRowView(photoInfo: $photoInfo)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Last 20 Astronomy Photos of the Day")
            .navigationBarTitleDisplayMode(.inline)
            
            .task {
                await photoInfoVM.fetchLastTwentyDays()
            }
        }
    }
}

#Preview {
    PhotoListView()
}
