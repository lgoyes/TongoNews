//
//  RemoteLoginRepository.swift
//  TongoNews
//
//  Created by Luis Goyes Garces on 22/03/21.
//

import Foundation

final class RemoteLoginRepository: LoginRepositoryType {
    weak var jsonDecoder: JSONDecoder?
    init(jsonDecoder: JSONDecoder) {
        self.jsonDecoder = jsonDecoder
    }
    
    func login(with credentials: Credentials, onSuccess: @escaping (LoginResponse) -> (), onError: @escaping (LoginRepositoryError) -> ()) {
        let urlString = EndpointPath.auth
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            onError(.networkFailure)
            return
        }
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = 10;
        let session = URLSession(configuration: sessionConfiguration)
        let dataTask = session.dataTask(with: url) { [weak self] (data, response, error) in
            DispatchQueue.main.async { [weak self] in
                self?.processResponse(data: data, response: response, error: error, onSuccess: onSuccess, onError: onError)
            }
        }
        dataTask.resume()
    }
    
    func processResponse(data: Data?, response: URLResponse?, error: Error?, onSuccess: @escaping (LoginResponse) -> (), onError: @escaping (LoginRepositoryError) -> ()) {
        if let error = error {
            print("Network error: \(error.localizedDescription)")
            onError(.networkFailure)
            return
        }
        guard let jsonDecoder = self.jsonDecoder else {
            print("JSONDecoder dependency can not be nil")
            onError(.internalError)
            return
        }
        guard let data = data else {
            print("Data should not be nil")
            onError(.serverFailure)
            return
        }
        do {
            let apiResponse = try jsonDecoder.decode(APILoginResponse.self, from: data)
            let response = mapAPIResponse(apiResponse)
            onSuccess(response)
        } catch let error {
            print("Fail to perform JSONDecoder decode: \(error.localizedDescription)")
            onError(.internalError)
        }
    }
    
    func mapAPIResponse(_ apiResponse: APILoginResponse) -> LoginResponse {
        let loginResponse = LoginResponse(authToken: apiResponse.authToken, expiresIn: apiResponse.expiresIn)
        return loginResponse
    }
}
