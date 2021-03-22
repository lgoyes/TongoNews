//
//  LocalLoginRepository.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 17/03/21.
//

final class LocalLoginRepository: LoginRepositoryType {
    func login(with credentials: Credentials, onSuccess: @escaping (LoginResponse) -> (), onError: @escaping (LoginRepositoryError) -> ()) {
        if credentials.email == "test@test.com" {
            let loginResponse = LoginResponse(authToken: "test@test.com", expiresIn: 3600)
            onSuccess(loginResponse)
        } else if credentials.email == "networkerror@test.com" {
            onError(.networkFailure)
        } else if credentials.email == "internalerror@test.com" {
            onError(.internalError)
        } else if credentials.email == "serverfailure@test.com" {
            onError(.serverFailure)
        } else {
            onError(.invalidCredentials)
        }
    }
}
