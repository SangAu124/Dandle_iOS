//
//  VideoDiaryAPI.swift
//  Dandle
//
//  Created by dev상금 on 6/14/24.
//

import Moya

// VideoDiaryService.swift
enum VideoDiaryAPI {
    case fetchVideoDiaries
    case fetchVideoDiary(id: UUID)
    case saveVideoDiary(diary: Reel)
    case deleteVideoDiary(id: UUID)
}

extension VideoDiaryAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.example.com")!
    }

    var path: String {
        switch self {
        case .fetchVideoDiaries:
            return "/video-diaries"
        case .fetchVideoDiary(let id):
            return "/video-diaries/\(id)"
        case .saveVideoDiary:
            return "/video-diaries"
        case .deleteVideoDiary(let id):
            return "/video-diaries/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .fetchVideoDiaries, .fetchVideoDiary:
            return .get
        case .saveVideoDiary:
            return .post
        case .deleteVideoDiary:
            return .delete
        }
    }

    var task: Task {
        switch self {
        case .fetchVideoDiaries, .fetchVideoDiary:
            return .requestPlain
        case .saveVideoDiary(let diary):
            return .requestJSONEncodable(diary)
        case .deleteVideoDiary:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
