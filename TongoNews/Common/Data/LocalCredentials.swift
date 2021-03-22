//
//  LocalCredentials.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 22/03/21.
//

import Foundation

// MARK: - Abstract Types

protocol LocalCredentials {
    static func getEmail() -> String
}

protocol LocalErrorCredentials: LocalCredentials {
    static func getError() -> LoginRepositoryError
}

protocol LocalSuccessCredentials: LocalCredentials {
    static func getToken() -> String
}

// MARK: - Implementation

struct NetworkErrorCredentials: LocalErrorCredentials {
    static func getEmail() -> String {
        return "networkerror@test.com"
    }
    static func getError() -> LoginRepositoryError {
        return .networkFailure
    }
}

struct InternalErrorCredentials: LocalErrorCredentials {
    static func getEmail() -> String {
        "internalerror@test.com"
    }
    static func getError() -> LoginRepositoryError {
        return .internalError
    }
}

struct ServerFailureCredentials: LocalErrorCredentials {
    static func getEmail() -> String {
        "serverfailure@test.com"
    }
    static func getError() -> LoginRepositoryError {
        return .serverFailure
    }
}

struct InvalidErrorCredentials: LocalErrorCredentials {
    static func getEmail() -> String {
        "invalidcredentials@test.com"
    }
    static func getError() -> LoginRepositoryError {
        return .invalidCredentials
    }
}

struct TestSuccessCredentials: LocalSuccessCredentials {
    static func getEmail() -> String {
        "test@test.com"
    }
    static func getToken() -> String {
        return "test-token"
    }
}
