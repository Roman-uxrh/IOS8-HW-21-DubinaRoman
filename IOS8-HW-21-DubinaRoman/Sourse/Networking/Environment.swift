//
//  Environment.swift
//  IOS8-HW-21-DubinaRoman
//
//  Created by admin on 20.03.2023.
//

import Foundation

struct Environment{
    static private var shame = "https"
    static private var host = "gateway.marvel.com"
    
    static var baseURL: String {
        "\(Environment.shame)://\(Environment.host)"
    }
}
