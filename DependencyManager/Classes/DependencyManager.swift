//
//  DependencyManager.swift
//  DependencyManager
//
//  Created by Michael Vorontsov on 08/10/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

/// Public interface for Dependency Manager, all specific dependencies had to be described as extension to it.
public protocol DependencyManagerProtocol: PublicServicePorotocol {
    
    /// Reset (nullify) all contained dependancies
    func reset()
    
    /// Get existed service by key, or create and store new one
    ///
    /// - Parameters:
    ///   - key: Key to retrive/store service
    ///   - creator: Block to create new service. Can containe all necessary dependencies
    /// - Returns: Service required
    func resolve<T: PublicServicePorotocol>(key: String, creator: ()->(T) ) -> T
}

/// Empty protocol to declare conformance to classes that can be managed by DpendencyManager.
@objc public protocol PublicServicePorotocol: class {}

/// Dummy class to access Implementation of DependencyManager via shared
public class DependencyManager: DependencyManagerProtocol {
    private let worker: DependencyManagerProtocol
    
    private init?() {
        fatalError("Placeholder \(DependencyManager.self) never intended for use!")
        return nil
    }
    
    public static var  shared:  DependencyManagerProtocol {
        return  DependencyManagerImp.shared
    }
    
    public
    func reset() {
        fatalError("Placeholder \(self.self) never intended for use!")
    }
    
    public
    func resolve<T>(key: String, creator: () -> (T)) -> T {
        fatalError("Placeholder \(self.self) never intended for use!")
    }
}

/// Private implementation of Dependency Manager
fileprivate class DependencyManagerImp: DependencyManagerProtocol {
    
    static var shared: DependencyManagerProtocol = DependencyManagerImp()
    
    lazy var stores: NSMapTable<NSString, AnyObject>! = {
        return NSMapTable.strongToWeakObjects()
    }()
    
    func reset() {
        stores = NSMapTable<NSString, AnyObject>.strongToWeakObjects()
    }
    
    func resolve<T: PublicServicePorotocol>(key: String, creator: ()->(T) ) -> T {
        if let store = stores.object(forKey: key as NSString) as? T {
            return store
        }
        let store: T = creator()
        stores.setObject(store, forKey: key as NSString)
        return store
    }
    
}
