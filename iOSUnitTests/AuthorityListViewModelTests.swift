//
//  AuthorityListViewModelTests.swift
//  iOSTestTests
//
//  Created by m.houghton on 12/12/2022.
//

import XCTest
@testable import iOSTest

final class AuthorityListViewModelTests: XCTestCase {
    
    var viewModel: AuthorityListViewModel!
    var mockNetworkService: NetworkMock!
    
    @MainActor
    override func setUpWithError() throws {
        mockNetworkService = NetworkMock()
        viewModel = AuthorityListViewModel(networkProvider: mockNetworkService)
    }
    
    @MainActor
    func testViewModelSetsAuthorities() async {
        
        await viewModel.update()
        XCTAssertEqual(1, viewModel.authorities.count)
        
        let actualAuthority = viewModel.authorities[0]
        
        XCTAssertEqual(101, actualAuthority.id)
        XCTAssertEqual("Test Authority", actualAuthority.name)
    }
    
    @MainActor
    func testViewModelSetsErrorFalse_whenNoNetworkError() async {
        
        mockNetworkService.shouldThrow = false
        await viewModel.update()
        
        XCTAssertFalse(viewModel.hasError)
    }
    
    @MainActor
    func testViewModelSetsErrorTrue_whenNetworkError() async {
        
        mockNetworkService.shouldThrow = true
        await viewModel.update()
        
        XCTAssertTrue(viewModel.hasError)
    }
    
}

class NetworkMock: NetworkProvider {
    var shouldThrow = false
    
    func getAuthorities() async throws -> iOSTest.AuthoritiesResponse {
        if shouldThrow {
            throw AuthoritiesFetcherError.someError
        }
        
        let testAuthority = Authority(id: 101, name: "Test Authority")
        return AuthoritiesResponse(authorities: [testAuthority])
    }
    
    enum AuthoritiesFetcherError: Error {
        case someError
    }
}
