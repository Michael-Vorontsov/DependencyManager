//
//  TextService.h
//  DependencyManager
//
//  Created by Michael Vorontsov on 15/10/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

#import <UIKit/UIKit.h>
@import DependencyManager;

NS_ASSUME_NONNULL_BEGIN

@protocol TextServiceProtocol <NSObject, DMPublicServiceProtocol>

    - (NSString *)textForString:(NSString *)key;

@end

@interface TextService : NSObject<TextServiceProtocol>

    @property (nonatomic, strong) NSDictionary<NSString *, NSString *>* texts;
    
    
@end


@interface DMDependencyManager(TextServiceProvider)

    - (NSObject<TextServiceProtocol> *)resolveTextService;
    
@end

NS_ASSUME_NONNULL_END
