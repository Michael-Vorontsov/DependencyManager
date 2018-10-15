//
//  TextService.m
//  DependencyManager
//
//  Created by Michael Vorontsov on 15/10/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

#import "TextService.h"
@import DependencyManager;

@interface TextService ()
    
@end

@implementation TextService
    
    - (id)initWithTexts:(NSDictionary *)texts {
        self = [super init];
        
        if (nil != self) {
            _texts = [texts copy];
        }
        return self;
    }

- (NSDictionary<NSString *, NSString *>*) texts {
    if (nil == _texts) {
        _texts = [NSDictionary new];
    }
    return _texts;
}
    
- (NSString *)notfoundForKey:(NSString *)key {
    return [NSString stringWithFormat:@"Not text found for %@! Try from \n%@\n instead!",
            key, self.texts.allKeys.description];
}
    
- (NSString *)textForString:(NSString *)key {
    NSString *text = self.texts[[key lowercaseString]];
    if (nil != text) {
        return text;
    }
    return [self notfoundForKey:key];
}
    
@end



@implementation DMDependencyManager(TextServiceProvider)

//- (NSObject<TextServiceProtocol> *)resolveTextService {
- (id<TextServiceProtocol>)resolveTextService {

    return (id<TextServiceProtocol>)[self resolveWithKey:@"TextService" creatorBlock:^id<DMPublicServiceProtocol> _Nonnull
    {
        NSDictionary *texts = @{
                                @"a" : @"\"A\" you're adorable",
                                @"b" : @"\"B\" you're so beautiful",
                                @"c" : @"\"C\" you're so cute and full of charm."
                                };
                                
        
        return [[TextService alloc] initWithTexts: texts];
    }];
}

@end
