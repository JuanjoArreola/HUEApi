//
//  ConfigurationApiTests.swift
//  HUEApiTests
//
//  Created by Juan Jose Arreola Simon on 6/6/19.
//

import XCTest
import HUEApi

final class ConfigurationApiTests: XCTestCase {
    
    var api = ConfigurationApi(url: "http://192.168.0.100/")
    let username = "UgYUU4g5jBFToI5uS377t-j6dyhl0gCfjw8QAVI2"

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateUser() {
        let expectation = self.expectation(description: "user")
        
        api.createUser(named: "Tests", app: "HUEApi").success { user in
            log.debug(user)
            XCTFail()
        }.fail { error in
            XCTAssertTrue(error is HUEError)
            let hueError = error as! HUEError
            XCTAssertEqual(hueError.type, 101)
            log.error(error)
        }.finished {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testBasicConfiguration() {
        let expectation = self.expectation(description: "")
        
        api.basicConfiguration().success { configuration in
            log.debug(configuration)
        }.fail { error in
            log.error(error)
            XCTFail()
        }.finished {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testConfiguration() {
        let expectation = self.expectation(description: "")
        
        api.configuration(username: username).success { configuration in
            log.debug(configuration)
        }.fail { error in
            log.error(error)
            XCTFail()
        }.finished {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testDeleteUserUnauthorized() {
        let expectation = self.expectation(description: "")
        
        api.deleteUserWithId("491cd7dd-045a-4ace-b8c6-f2ec55dfbdd8", username: username).success { result in
            log.debug(result)
            XCTFail()
        }.fail { error in
            XCTAssertTrue(error is HUEError)
            let hueError = error as! HUEError
            XCTAssertEqual(hueError.type, 1)
        }.finished {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }

}
