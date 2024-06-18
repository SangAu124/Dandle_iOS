//
//  VideoDiaryDataSource.swift
//  Dandle
//
//  Created by dev상금 on 6/14/24.
//

import Foundation

class VideoDiaryDataSource: DanDDataSource<VideoDiaryRemote, Any?> {
  func fetchVideoDiaries() async throws -> [Reel] {
    return remote.fetchVideoDiaries()
  }
  
  func fetchVideoDiary(id: UUID) async throws -> Reel? {
    return remote.fetchVideoDiary(id: id)
  }

  func saveVideoDiary(_ diary: Reel) async throws {
    return remote.saveVideoDiary(diary)
  }

  func deleteVideoDiary(id: UUID) async throws {
    return remote.deleteVideoDiary(id: id)
  }
}
