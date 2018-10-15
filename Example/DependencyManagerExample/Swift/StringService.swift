//
//  StringService.swift
//  DependencyManager
//
//  Created by Michael Vorontsov on 08/10/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import DependencyManager

protocol FetchStringsServiceProtocol: PublicServicePorotocol {
    func fetchStrings(handler:  (([String]) -> () ) )
}

protocol SendStringServiceProtocol: PublicServicePorotocol {
    func sendString(string: String)
}

extension DependencyManagerProtocol {
    
    /// Private machanism to resolve StringService worker as composition of both protocols
    ///
    /// - Returns: Worker
    private func resolveStringsService() -> FetchStringsServiceProtocol & SendStringServiceProtocol {
        return self.resolve(key: "StringService") {
            StringServiceImp(string: "Hello World!")
        }
    }
    
    /// Service that fetching strings
    ///
    /// - Returns: String Fetcher
    func resolveFetchStringsService() -> FetchStringsServiceProtocol {
        return resolveStringsService()
    }

    /// Service that sending input for procession
    ///
    /// - Returns: String Sender
    func resolveSendStringService() -> SendStringServiceProtocol {
        return resolveStringsService()
    }
}

/// Single entity fulfill privately both responsobilities
fileprivate class StringServiceImp: FetchStringsServiceProtocol, SendStringServiceProtocol {
    
    private var mockedStrings: [String]
    
    let separators: CharacterSet
    
    init(string: String) {
        separators =  CharacterSet.alphanumerics.inverted
        mockedStrings = string.components(separatedBy: separators)
    }
    
    func fetchStrings(handler:  (([String]) -> () ) ) {
        handler (mockedStrings)
    }
    
    func sendString(string: String) {
        mockedStrings = string.components(separatedBy: separators)
    }
}
