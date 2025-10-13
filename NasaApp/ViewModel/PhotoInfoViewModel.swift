//
//  PhotoInfoViewModel.swift
//  NasaApp
//
//  Created by Olibo moni on 12/10/2025.
//

import Foundation
import Combine


@MainActor
class PhotoInfoViewModel: ObservableObject {
    @Published var photoInfos: [PhotoInfo] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?
    
    func fetchLastTwentyDays() async {
        guard photoInfos.isEmpty else { return }
        isLoading = true
        errorMessage = nil
        
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        //        let today = Date.now
        
        
        guard let endDate = dateFormatter.date(from: "2025-01-31"),
              let startDate = calendar.date(byAdding: .day, value: -19, to: endDate) else {
            errorMessage = "Date range out of scope."
            isLoading = false
            return
        }
        
        var dates: [Date] = []
        var currentDate = startDate
        while currentDate <= endDate {
            dates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        do {
            let infos = try await withThrowingTaskGroup(of: PhotoInfo.self) { group in
                var results = [PhotoInfo]()
                
                for date in dates {
                    let dateString = dateFormatter.string(from: date)
                    group.addTask {
                        return try await self.fetchPhotoInfo(for: dateString)
                    }
                }
                for try await info in group {
                    results.append(info)
                }
                return results
            }
            
            self.photoInfos = infos.sorted { $0.date > $1.date }
            
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    
    private func fetchPhotoInfo(for date: String) async throws -> PhotoInfo {
        var urlComponents = URLComponents(string: "https://api.nasa.gov/planetary/apod")!
        urlComponents.queryItems = [
            "api_key": "23o8zS6tiFaWwuqxQKjdsFs1Ol8sJT9ax9J6rTM5",
            "date": date
        ].map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = urlComponents.url else {
            throw PhotoInfoError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw PhotoInfoError.invalidServerResponse
        }
        
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode(PhotoInfo.self, from: data)
    }
}
