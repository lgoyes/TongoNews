//
//  LoginRepositoryType.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 17/03/21.
//

enum LoginRepositoryError: Error {
    case invalidCredentials
    case networkFailure
}
protocol LoginRepositoryType: AnyObject {
    typealias Credentials = (email: String, password: String)
    
    func login(with credentials: Credentials, onSuccess: @escaping (LoginResponse) -> (), onError: @escaping (LoginRepositoryError) -> ())
}
