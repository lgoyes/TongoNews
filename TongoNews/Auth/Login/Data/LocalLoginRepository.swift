//
//  LocalLoginRepository.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 17/03/21.
//

class LocalLoginRepository: LoginRepositoryType {
    func login(with credentials: Credentials, onSuccess: @escaping (LoginResponse) -> (), onError: @escaping (LoginRepositoryError) -> ()) {
        if credentials.email == "test@test.com" {
            let loginResponse = LoginResponse(authToken: "test@test.com", expiresIn: 3600)
            onSuccess(loginResponse)
        } else {
            onError(.invalidCredentials)
        }
    }
}
