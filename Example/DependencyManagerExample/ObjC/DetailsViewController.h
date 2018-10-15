//
//  ObjcViewController.h
//  DependencyManager
//
//  Created by Michael Vorontsov on 15/10/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextService.h"
@import DependencyManager;

//@import DependencyManager;

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

    @property (nonatomic, retain) TextService* textService;
    @property (nonatomic, strong) NSString* key;
    
@end

NS_ASSUME_NONNULL_END
