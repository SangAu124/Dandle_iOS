//
//  VideoDiaryRemote.swift
//  Dandle
//
//  Created by dev상금 on 6/14/24.
//

import Foundation
import Moya

class VideoDiaryRemote: DanDRemote<VideoDiaryAPI> {
    func fetchVideoDiaries() async throws -> [Reel] {
        let response = try await request(.fetchVideoDiaries)
        let entities = try JSONDecoder().decode([VideoDiaryEntity].self, from: response.data)
        return entities.map { $0.toDomain() }
    }
    
    func fetchVideoDiary(id: UUID) async throws -> Reel? {
        let response = try await request(.fetchVideoDiary(id: id))
        let entity = try JSONDecoder().decode(VideoDiaryEntity.self, from: response.data)
        return entity.toDomain()
    }

    func saveVideoDiary(_ diary: Reel) async throws {
        let entity = VideoDiaryEntity(
            id: diary.id,
            title: diary.title,
            description: diary.description,
            videoURLString: diary.videoURL.absoluteString,
            date: diary.date
        )
        _ = try await request(.saveVideoDiary(diary: entity))
    }

    func deleteVideoDiary(id: UUID) async throws {
        _ = try await request(.deleteVideoDiary(id: id))
    }
}
