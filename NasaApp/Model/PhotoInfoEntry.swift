//
//  PhotoInfoEntry.swift
//  NasaApp
//
//  Created by Olibo moni on 13/10/2025.
//

import Foundation
import SwiftUI

enum PhotoInfoEntry: Identifiable {
    case success(PhotoInfo)
    case failure(id: String)

    var id: String {
        switch self {
        case .success(let photoInfo):
            return photoInfo.date
        case .failure(let id):
            return id
        }
    }
}
