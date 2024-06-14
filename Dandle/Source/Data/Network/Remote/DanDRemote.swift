//
//  DanDRemote.swift
//  Dandle
//
//  Created by 상dev on 6/14/24.
//

import Foundation
import Moya

protocol Networkable {
    associatedtype API: TargetType
    var provider: MoyaProvider<API> { get }
}

public class DanDRemote<T: TargetType>: Networkable {
    lazy var request = TokenRefreshRequest(refreshToken: AuthController.getInstance().getRefreshToken())
    
#if DEBUG
    lazy var authProvider = MoyaProvider<DodamTokenAPI>(plugins: [NetworkLoggerPlugin()])
    let provider: MoyaProvider<T>
#else
    lazy var authProvider = MoyaProvider<DodamTokenAPI>()
    let provider: MoyaProvider<T>
#endif
    
    let decoder = JSONDecoder()
    
    public init(provider: MoyaProvider<T> = MoyaProvider<T>(plugins: [NetworkLoggerPlugin()])) {
        self.provider = provider
    }
    
    func request(_ target: T) async throws -> Moya.Response {
        do {
            return try await provider.asyncRequest(target)
        } catch {
            if let moyaError = error as? MoyaError,
               case let .statusCode(response) = moyaError,
               response.statusCode == 410 {
                return try await tokenRefresh(target: target)
            } else {
                throw DodamError.error(message: "네트워크 오류가 발생했습니다.", type: .networkError, errorBody: ["where": "BaseRemote:29"])
            }
        }
    }
    
    private func tokenRefresh(target: T) async throws -> Moya.Response {
        do {
            let response = try await authProvider.asyncRequest(.tokenRefresh(request))
            let tokenResponse = try decoder.decode(Response<String>.self, from: response.data)
            AuthController.getInstance().tokenRefresh(token: tokenResponse.data)
            return try await provider.asyncRequest(target)
        } catch {
            if let moyaError = error as? MoyaError,
               case let .statusCode(response) = moyaError,
               response.statusCode == 410 {
                throw DodamError.error(message: "세션이 만료되었습니다.")
            } else {
                throw DodamError.error(message: "네트워크 오류가 발생했습니다.", type: .networkError, errorBody: ["where":"BaseRemote:43"])
            }
        }
    }
}

extension MoyaProvider {
    func asyncRequest(_ target: Target) async throws -> Moya.Response {
        try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
