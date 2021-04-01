//
//  LoginWithCredentialsInteractorTests.swift
//  TongoNewsTests
//
//  Created by Luis Goyes Garces on 1/04/21.
//

import XCTest
@testable import TongoNews

final class LoginWithCredentialsInteractorTests: XCTestCase {
    var sut: LoginWithCredentialsInteractor!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = LoginWithCredentialsInteractor(config: SystemConfig.test)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    // MARK: - init with config
    
    func test_WhenInitWithDevSystemConfig_SetLoginRepositoryasLocalInstance() {
        let sut = LoginWithCredentialsInteractor(config: SystemConfig.dev)
        XCTAssertTrue(sut.loginRepository is LocalLoginRepository)
    }
    
    func test_WhenInitWithTestSystemConfig_SetLoginRepositoryasLocalInstance() {
        let sut = LoginWithCredentialsInteractor(config: SystemConfig.test)
        XCTAssertTrue(sut.loginRepository is LocalLoginRepository)
    }
    
    func test_WhenInitWithProdSystemConfig_SetLoginRepositoryasRemoteInstance() {
        let sut = LoginWithCredentialsInteractor(config: SystemConfig.prod)
        XCTAssertTrue(sut.loginRepository is RemoteLoginRepository)
    }
    
    // MARK: - init with loginRepository
    
    func test_WhenInitWithLoginRepository_SetLoginRepository() {
        let fakeLoginRepository = FakeLoginRepository()
        let sut = LoginWithCredentialsInteractor(loginRepository: fakeLoginRepository)
        XCTAssertTrue(sut.loginRepository === fakeLoginRepository)
    }
    
    // MARK: - execute
    
    func test_WhenExecute_InvokePerformLoginRequest() {
        let fakeLoginRepository = FakeLoginRepository()
        let sut = SeamLoginWithCredentialsInteractor(loginRepository: fakeLoginRepository)
        
        sut.execute(with: (email: "", password: "")) { } onError: { _ in }
        
        XCTAssertTrue(sut.performLoginRequestWasCalled)
    }
    
    func test_GivenLoginRepositoryError_WhenExecute_InvokeOnErrorCallback() {
        let fakeLoginRepository = FakeLoginRepository()
        fakeLoginRepository.onSuccessExpected = false
        fakeLoginRepository.error = .internalError
        let sut = SeamLoginWithCredentialsInteractor(loginRepository: fakeLoginRepository)
        
        let correctExpectation = XCTestExpectation(description: "onError should be called")
        let incorrectExpectation = XCTestExpectation(description: "onSuccess should not be called")
        incorrectExpectation.isInverted = true
        
        sut.execute(with: (email: "", password: "")) {
            incorrectExpectation.fulfill()
        } onError: { _ in
            correctExpectation.fulfill()
        }
        
        wait(for: [correctExpectation, incorrectExpectation], timeout: 0.1)
    }
    
    // MARK - performRequest
    
    func test_GivenSuccessResponseFromRepository_WhenPerformRequest_InvokeOnSuccessCallback() {
        let fakeLoginRepository = FakeLoginRepository()
        fakeLoginRepository.onSuccessExpected = true
        fakeLoginRepository.loginResponse = LoginResponse(authToken: "", expiresIn: 1)
        
        let sut = SeamLoginWithCredentialsInteractor(loginRepository: fakeLoginRepository)
        
        let correctExpectation = XCTestExpectation(description: "onSuccess should be called")
        let incorrectExpectation = XCTestExpectation(description: "onError should not be called")
        incorrectExpectation.isInverted = true
        
        sut.performLoginRequest(credentials: (email: "", password: ""), onSuccess: {_ in
            correctExpectation.fulfill()
        }, onError: {_ in
            incorrectExpectation.fulfill()
        })
        
        wait(for: [correctExpectation, incorrectExpectation], timeout: 0.1)
    }
    
    func test_GivenErrorResponseFromRepository_WhenPerformRequest_InvokeOnErrorCallback() {
        let fakeLoginRepository = FakeLoginRepository()
        fakeLoginRepository.onSuccessExpected = false
        fakeLoginRepository.error = .internalError
        
        let sut = SeamLoginWithCredentialsInteractor(loginRepository: fakeLoginRepository)
        
        let correctExpectation = XCTestExpectation(description: "onError should be called")
        let incorrectExpectation = XCTestExpectation(description: "onSuccess should not be called")
        incorrectExpectation.isInverted = true
        
        sut.performLoginRequest(credentials: (email: "", password: ""), onSuccess: {_ in
            incorrectExpectation.fulfill()
        }, onError: {_ in
            correctExpectation.fulfill()
        })
        
        wait(for: [correctExpectation, incorrectExpectation], timeout: 0.1)
    }
    
    // MARK: - mapApiError
    
    func test_GivenNetworkError_WhenMapApiError_ReturnNetworkError() {
        let error = sut.mapApiError(.networkFailure)
        XCTAssertEqual(error, .networkFailure)
    }
    
    func test_GivenInvalidCredentials_WhenMapApiError_ReturnInvalidCredentials() {
        let error = sut.mapApiError(.invalidCredentials)
        XCTAssertEqual(error, .invalidCredentials)
    }
    
    func test_GivenInternalError_WhenMapApiError_ReturnServerError() {
        let error = sut.mapApiError(.internalError)
        XCTAssertEqual(error, .serverFailure)
    }
    
    func test_GivenServerError_WhenMapApiError_ReturnServerError() {
        let error = sut.mapApiError(.serverFailure)
        XCTAssertEqual(error, .serverFailure)
    }
    
}

fileprivate class FakeLoginRepository: LoginRepositoryType {
    var onSuccessExpected = false
    var loginResponse: LoginResponse?
    var error: LoginRepositoryError?
    func login(with credentials: Credentials, onSuccess: @escaping (LoginResponse) -> (), onError: @escaping (LoginRepositoryError) -> ()) {
        if onSuccessExpected, let loginResponse = self.loginResponse {
            onSuccess(loginResponse)
        } else if !onSuccessExpected, let error = self.error {
            onError(error)
        }
    }
}

fileprivate class SeamLoginWithCredentialsInteractor: LoginWithCredentialsInteractor {
    var performLoginRequestWasCalled = false
    override func performLoginRequest(credentials: LoginWithCredentialsInteractor.Credentials, onSuccess: @escaping (LoginResponse) -> (), onError: @escaping (LoginInteractableError) -> ()) {
        super.performLoginRequest(credentials: credentials, onSuccess: onSuccess, onError: onError)
        performLoginRequestWasCalled = true
    }
}
