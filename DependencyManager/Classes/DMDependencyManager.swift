//
//  DMDependencyManager.swift
//  DependencyManager
//
//  Created by Michael Vorontsov on 15/10/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

@objc public
protocol DMPublicServiceProtocol: PublicServicePorotocol {}

@objc public
protocol DMDependencyManagerProtocol: NSObjectProtocol {
    
    func resolveWithKey(_ key: String, creatorBlock: ( () -> (DMPublicServiceProtocol) ) ) -> DMPublicServiceProtocol
    func reset()
    
}

@objc public
class DMDependencyManager: NSObject,  DMDependencyManagerProtocol, DependencyManagerProtocol {
    
    private var imp: DependencyManagerProtocol
    
    override init() {
        imp = DependencyManager.shared
    }
    
    @objc public
    static var shared: DMDependencyManagerProtocol = {
        return DMDependencyManager()
    }()

    
    public func resolve<T>(key: String, creator: () -> (T)) -> T where T : PublicServicePorotocol {
        return imp.resolve(key: key, creator: creator)
    }
    
    @objc public func resolveWithKey(_ key: String, creatorBlock: ( () -> (DMPublicServiceProtocol) ) ) -> DMPublicServiceProtocol {
        return resolve(key: key, creator: creatorBlock)
    }

    @objc public func reset() {
        imp.reset()
    }
}
