//
//  Reel.swift
//  Dandle
//
//  Created by dev상금 on 6/12/24.
//

import SwiftUI

struct Reel: Identifiable {
    var id: UUID = .init()
    var videoID: String
    var authorName: String
    var isLiked: Bool = false
}

var reelsData: [Reel] = [
    .init(videoID: "reel1", authorName: "김상은"),
    .init(videoID: "reel2", authorName: "장정원"),
    .init(videoID: "reel3", authorName: "이영은"),
    .init(videoID: "reel4", authorName: "우준성"),
    .init(videoID: "reel5", authorName: "박병관")
]
