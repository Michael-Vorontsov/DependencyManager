//
//  DependencyManagerTests.swift
//  DependencyManagerTests
//
//  Created by Michael Vorontsov on 08/10/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import DependencyManager

fileprivate protocol TestSerivceProtocol: PublicServicePorotocol {
    var name: String? { get }
}

fileprivate class TestServiceImp: TestSerivceProtocol {
    
    let name: String?
    
    init(name: String?) {
        self.name = name
    }
}

private let defaultTestServiceName = "Default Test Service"

extension DependencyManagerProtocol {
    
    fileprivate func testService(name: String? = nil) -> TestSerivceProtocol {
        let key = name ?? defaultTestServiceName
        return self.resolve(key: key) {
            return TestServiceImp(name: name)
        }
    }
    
}

class DependencyManagerTests: XCTestCase {
    
    
    /// Default services and stored and provided on-demand
    /// by not specifying any  dependecy
    func testSericeProvider() {
        
        let serviceA:TestSerivceProtocol = DependencyManager.shared.testService()
        let serviceB:TestSerivceProtocol = DependencyManager.shared.testService()
        
        XCTAssertTrue(serviceA === serviceB)
    }
    
    /// DependencyManager can be used to create services with specific parameters.
    /// It means that specifc impementation can vary (However not guaranty as it is up to Developer)
    /// This services are not stored and created explicitly each time.
    func testOnDemandDependencyManager() {
        
        let serviceA:TestSerivceProtocol = DependencyManager.shared.testService()
        let serviceB:TestSerivceProtocol = DependencyManager.shared.testService(name: "A")
        let serviceC:TestSerivceProtocol = DependencyManager.shared.testService(name: "B")

        /// Explicit services recreated even same dependecy had been used
        XCTAssertFalse(serviceA === serviceC)
        
        /// Excplicit services recreated each time
        XCTAssertFalse(serviceC === serviceB)
        
    }
    
    func testSericeProviderWeakReferencing() {
        
        weak var serviceB:TestSerivceProtocol?
        var serviceA:TestSerivceProtocol? = DependencyManager.shared.testService()
        
        /// Hash table is behind storing services on-demand.
        /// Explicit Autorelease pool required to force memory deallocation
        
        autoreleasepool {
            serviceB = DependencyManager.shared.testService()
            XCTAssertTrue(serviceA === serviceB)
            XCTAssertTrue(serviceA === DependencyManager.shared.testService())
            XCTAssertTrue(DependencyManager.shared.testService() === serviceB)
            serviceA = nil
            /// Although no strong refrerences left, weak serviceB still intact
            XCTAssertNotNil(serviceB)
        }
        
        /// Autorelease pool drained, and weak serviceB nullified!
        XCTAssertNil(serviceB)
    }
    
}
