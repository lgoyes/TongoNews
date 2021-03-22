//
//  LocalLoginRepository.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 17/03/21.
//

final class LocalLoginRepository: LoginRepositoryType {
    var directory: [String: LocalCredentials.Type]
    init(directory: [String: LocalCredentials.Type]?) {
        if let directory = directory {
            self.directory = directory
        } else {
            self.directory = [:]
            let directoryCredentials: [LocalCredentials.Type] = [TestSuccessCredentials.self, NetworkErrorCredentials.self, InternalErrorCredentials.self, ServerFailureCredentials.self, InvalidErrorCredentials.self]
            for credentials in directoryCredentials {
                self.directory[credentials.getEmail()] = credentials
            }
        }
    }
    
    func login(with credentials: Credentials, onSuccess: @escaping (LoginResponse) -> (), onError: @escaping (LoginRepositoryError) -> ()) {
        
        if let errorCredentials = directory[credentials.email] as? LocalErrorCredentials.Type {
            onError(errorCredentials.getError())
        } else if let successCredentials = directory[credentials.email] as? LocalSuccessCredentials.Type {
            let token = successCredentials.getToken()
            let response = LoginResponse(authToken: token, expiresIn: 3600)
            onSuccess(response)
        }
    }
}
