//
//  APILoginResponse.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 22/03/21.
//

import Foundation

struct APILoginResponse: Decodable {
    let authToken: String
    let expiresIn: Int
}
