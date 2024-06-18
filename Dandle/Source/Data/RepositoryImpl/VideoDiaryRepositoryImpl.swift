//
//  VideoDiaryRepositoryImpl.swift
//  Dandle
//
//  Created by dev상금 on 6/14/24.
//

import Foundation

class VideoDiaryRepositoryImpl: VideoDiaryRepository {
  private let dataSource: VideoDiaryDataSource
  
  init(dataSource: VideoDiaryDataSource) {
    self.dataSource = dataSource
  }
  
  func fetchVideoDiaries() async throws -> [Reel] {
    return try await remote.fetchVideoDiaries()
  }
  
  func fetchVideoDiary(id: UUID) async throws -> Reel? {
    return try await remote.fetchVideoDiary(id: id)
  }
  
  func saveVideoDiary(_ diary: Reel) async throws {
    try await remote.saveVideoDiary(diary)
  }
  
  func deleteVideoDiary(id: UUID) async throws {
    try await remote.deleteVideoDiary(id: id)
  }
}
