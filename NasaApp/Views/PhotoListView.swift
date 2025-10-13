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
    @State private var selectedEndDate: Date = .now
    @State private var isDatePickerPresented = false
    
    var body: some View {
        NavigationStack {
            Group {
                if photoInfoVM.isLoading && photoInfoVM.photoInfoEntries.isEmpty {
                    ProgressView("Fetching Photos...")
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
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("NASA Daily Photos")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isDatePickerPresented = true
                    } label: {
                        Image(systemName: "calendar")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isDatePickerPresented) {
                DatePickerView(selectedDate: $selectedEndDate) {
                    Task {
                        await photoInfoVM.fetchPhotoEntries(for: selectedEndDate)
                    }
                }
            }
            .task {
                await photoInfoVM.fetchPhotoEntries(for: selectedEndDate)
            }
        }
    }
}

#Preview {
    PhotoListView()
}

