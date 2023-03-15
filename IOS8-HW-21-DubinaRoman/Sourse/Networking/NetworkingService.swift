//
//  Networking.swift
//  IOS8-HW-21-DubinaRoman
//
//  Created by admin on 14.03.2023.
//

import Foundation
import CryptoKit
import Alamofire

final class NetworkingService {
    
    // Функция для создания hash
    private func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
    // Функция для создания URL
    func createUrlMarvel() -> URL? {
        
        let publicKey = "7c163ec46d141101c5b997c5d689023c"
        let privateKey = "4acd848ded080859cc62c3b9f8e2a843dbfa20db"
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(string: "\(ts)\(privateKey)\(publicKey)")
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "gateway.marvel.com"
        components.path = "/v1/public/characters"
        components.queryItems = [URLQueryItem(name: "ts", value: ts),
                                URLQueryItem(name: "apiKey", value: publicKey),
                                URLQueryItem(name: "hash", value: hash)]
        
        let url = components.url
        return url
    }
    
    func getData(url: URL?, competion: @escaping (Result<AnswerMarvelService, NetworkingError>) -> Void) {
        guard let url = url else {
            competion(.failure(.badUrl))
            return
        }
        
        AF.request(url)
            .validate()
            
    }
}

    
