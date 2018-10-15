# DependencyManager

[![CI Status](https://img.shields.io/travis/Michael-Vorontsov/DependencyManager.svg?style=flat)](https://travis-ci.org/Michael-Vorontsov/DependencyManager)
[![Version](https://img.shields.io/cocoapods/v/DependencyManager.svg?style=flat)](https://cocoapods.org/pods/DependencyManager)
[![License](https://img.shields.io/cocoapods/l/DependencyManager.svg?style=flat)](https://cocoapods.org/pods/DependencyManager)
[![Platform](https://img.shields.io/cocoapods/p/DependencyManager.svg?style=flat)](https://cocoapods.org/pods/DependencyManager)

DependencyManager provides simple interface for declaring ***weak*** dependencies.  ***Weak*** means that dependencies will live in memory as long as some other part of app keep using it, and will autoreleased when it's no longer needed, reducing memory footprint. 

DepedencyManager itself provides ability to retrieve/create new services by keys using ```swift resolve<T>(key: String, creator: () -> (T))``` function by unique key for services and creator block that should be called when services had to be recreated. 

Generally it is recommended to describe public interface to intended services as ```Protocol```  then, then provide implementation as private class conforming to the protocol and in that same file declare extension to DependencyManagerProtocol to create specific implementation as the protocol: 
 
 ```swift
 
 protocol FetchStringsServiceProtocol: PublicServicePorotocol {
    func fetchStrings(handler:  (([String]) -> () ) )
 }
 
 extension DependencyManagerProtocol {
    func resolveFetchStringsService() -> FetchServiceProtocol {
        return self.resolve(key: "StringService") {
            StringServiceImp(...)
        }
    }
 }
  
 private class StringServiceImp: FetchStringsServiceProtocol {
    
    func fetchStrings(handler:  (([String]) -> () ) ) {
        ...
    }
 }
``` 

Please see *Expample* for additional details.
 

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Framework compliant with *Swift4.2* and by so require *XCode10*. 

## Installation

DependencyManager is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'DependencyManager'
```

Or via Carthage
```ruby
github "Michael-Vorontsov/DependencyManager"
```

## Author

Michael Vorontsov, michel06@ukr.net

## License

DependencyManager is available under the MIT license. See the LICENSE file for more info.

