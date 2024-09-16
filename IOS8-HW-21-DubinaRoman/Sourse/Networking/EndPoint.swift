//
//  EndPoint.swift
//  IOS8-HW-21-DubinaRoman
//
//  Created by admin on 20.03.2023.
//

import Foundation
import CryptoKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol Request<T> {
    associatedtype T
    var endpoint: Endpoint { get }
    func decode<T: Decodable>(data: Data) throws -> T
}

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String] { get }
    var parameters: [String: Any] { get }
}

//extension Request {
//    func decode<T: Decodable>(data: Data) throws -> T {
//        return try JSONDecoder().decode(T.self, from: data)
//    }
//}

extension Endpoint {
    var header: [String: String] {
        [:]
    }
    var parameters: [String: Any] {
        [:]
    }
}

enum CharactersEndpoint: Endpoint {
    case characters
    
    var path: String {
        switch self {
            case .characters:
               return "/v1/public/characters"
        }
    }

    var method: HTTPMethod {
        switch self {
            case .characters:
                return .get
        }
    }
    
    var parameters: [String : Any] {
        switch self {
            case .characters:
                let publicKey = "7c163ec46d141101c5b997c5d689023c"
                let privateKey = "4acd848ded080859cc62c3b9f8e2a843dbfa20db"
                let ts = String(Date().timeIntervalSince1970)
                let hash = "\(ts)\(privateKey)\(publicKey)".MD5()
                
                return ["limit": "100", "ts": ts, "apikey": publicKey, "hash": hash]
        }
    }
}

extension String {
    func MD5() -> String {
        let digest = Insecure.MD5.hash(data: data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}

struct CharactersRequest: Request {
    
    func decode<T>(data: Data) throws -> T where T : Decodable {
        return T.Type.self as! T
    }
    
    typealias T = [CharacterMarvel]
    
    var endpoint: Endpoint = CharactersEndpoint.characters
    
    func decode(data: Data) throws -> [CharacterMarvel] {
        let decoder = JSONDecoder()
        guard let data = try? decoder.decode(AnswerMarvelService.self, from: data),
              let result = data.data?.results else {
            throw NetworkingError.decoding }
        return result
    }
}

protocol NetworkDispather {
    func request<T: Decodable>(_ model: any Request) async throws -> T
}

class NetworkDispatherImpl: NetworkDispather {
    
    func request<T: Decodable>(_ model: any Request) async throws -> T {
        let baseURL = Environment.baseURL + model.endpoint.path
        guard var components = URLComponents(string: baseURL) else { throw NetworkingError.invalidParametrs }
        
        var queryItems = [URLQueryItem]()
        model.endpoint.parameters.forEach { result in
            queryItems.append(.init(name: result.key, value: "\(result.value)"))
        }
        
        components.queryItems = queryItems
        
        guard let url = components.url else { throw NetworkingError.badUrl }
        var request = URLRequest(url: url)
        request.httpMethod = model.endpoint.method.rawValue
        
        let (data, response ) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
                200..<300 ~= httpResponse.statusCode  else {
            throw URLError(.badServerResponse)
        }
        
        return try model.decode(data: data)
        
//        guard let data = data else { throw NetworkingError.invalidData }
    }
}
