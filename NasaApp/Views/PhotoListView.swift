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
                if photoInfoVM.isLoading && photoInfoVM.photoInfoEntries.isEmpty {
                    ProgressView("Fetching Photos...")
                } else if let errorMessage = photoInfoVM.errorMessage {
                    ErrorView(errorMessage: errorMessage)
                } else {
                    List($photoInfoVM.photoInfoEntries) { photoInfoEntry in
                        switch photoInfoEntry.wrappedValue{
                        case .success(let photoInfo):
                            let photoInfoBinding = Binding(
                                get: {
                                    if case .success(let info) = photoInfoEntry.wrappedValue {
                                        return info
                                    } else {
                                        return photoInfo
                                    }
                                },
                                set: { newPhotoInfo in
                                    photoInfoEntry.wrappedValue = .success(newPhotoInfo)
                                }
                            )
                            PhotoRowView(photoInfo: photoInfoBinding)
                            
                        case .failure(id: let date):
                            MissingDataRowView(date: date)
                        }
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

