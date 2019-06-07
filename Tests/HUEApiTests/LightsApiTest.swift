//
//  LightsApiTest.swift
//  HUEApiTests
//
//  Created by Juan Jose Arreola Simon on 6/6/19.
//

import XCTest
import HUEApi

class LightsApiTest: XCTestCase {
    
    var api = LightsApi(url: "http://192.168.0.101/", username: "UgYUU4g5jBFToI5uS377t-j6dyhl0gCfjw8QAVI2")

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLights() {
        let expectation = self.expectation(description: "lights")
        
        api.lights().success { lights in
            print(lights)
        }.fail { error in
            print(error)
        }.finished {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLight() {
        let expectation = self.expectation(description: "light")
        
        api.light(id: "1").success { light in
            print(light)
        }.fail { error in
            print(error)
        }.finished {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLightOn() {
        let expectation = self.expectation(description: "light")
        
        let state = SetLightState(on: true)
        api.setState(state, of: "1").success { light in
            print(light)
        }.fail { error in
            print(error)
            XCTFail()
        }.finished {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLightOff() {
        let expectation = self.expectation(description: "light")
        
        let state = SetLightState(on: false)
        api.setState(state, of: "1").success { light in
            print(light)
            }.fail { error in
                print(error)
                XCTFail()
            }.finished {
                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

}
