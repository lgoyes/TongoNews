//
//  LoginWithCredentialsInteractor.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 1/04/21.
//

import Foundation

enum LoginInteractableError: Error {
    case invalidCredentials
    case networkFailure
    case serverFailure
}

protocol LoginInteractable: AnyObject {
    typealias Credentials = (email: String, password: String)
    
    func execute(with credentials: Credentials, onSuccess: @escaping () -> (), onError: @escaping (LoginInteractableError) -> ())
}

class LoginWithCredentialsInteractor: LoginInteractable {
    
    var loginRepository: LoginRepositoryType
    
    init(config: SystemConfig) {
        if config == .prod {
            loginRepository = RemoteLoginRepository(jsonDecoder: JSONDecoder())
        } else {
            loginRepository = LocalLoginRepository(directory: nil)
        }
    }
    
    init(loginRepository: LoginRepositoryType) {
        self.loginRepository = loginRepository
    }
    
    func execute(with credentials: Credentials, onSuccess: @escaping () -> (), onError: @escaping (LoginInteractableError) -> ()) {
        performLoginRequest(credentials: credentials) { [weak self] response in
            
        } onError: { (error) in
            onError(error)
        }
    }

    func performLoginRequest(credentials: Credentials, onSuccess: @escaping (LoginResponse) -> (), onError: @escaping (LoginInteractableError) -> ()) {
        loginRepository.login(with: credentials) { (response) in
            onSuccess(response)
        } onError: { [weak self] (apiError) in
            guard let self = self else { return }
            let error = self.mapApiError(apiError)
            onError(error)
        }
    }
    
    func mapApiError(_ apiError: LoginRepositoryError) -> LoginInteractableError {
        switch (apiError) {
        case .networkFailure:
            return .networkFailure
        case .invalidCredentials:
            return .invalidCredentials
        default:
            return .serverFailure
        }
    }
}
