//
//  ConfigurationApiTests.swift
//  HUEApiTests
//
//  Created by Juan Jose Arreola Simon on 6/6/19.
//

import XCTest
import HUEApi

final class ConfigurationApiTests: XCTestCase {
    
    var api = ConfigurationApi(url: "http://192.168.0.101/", username: "UgYUU4g5jBFToI5uS377t-j6dyhl0gCfjw8QAVI2")

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateUser() {
        let expectation = self.expectation(description: "user")
        
        api.createUser(named: "Tests", app: "HUEApi").success { user in
            print(user)
            XCTFail()
        }.fail { error in
            XCTAssertTrue(error is HUEError)
            let hueError = error as! HUEError
            XCTAssertEqual(hueError.type, 101)
            print(error)
        }.finished {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testConfiguration() {
        let expectation = self.expectation(description: "")
        
        api.configuration().success { configuration in
            print(configuration)
        }.fail { error in
            print(error)
            XCTFail()
        }.finished {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

}
