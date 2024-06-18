//
//  VideoDiaryRepository.swift
//  Dandle
//
//  Created by dev상금 on 6/14/24.
//

import Foundation

protocol VideoDiaryRepository {
    func fetchVideoDiaries() async throws -> [Reel]
    func fetchVideoDiary(id: UUID) async throws -> Reel?
    func saveVideoDiary(_ diary: Reel) async throws
    func deleteVideoDiary(id: UUID) async throws
}
