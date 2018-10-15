//
//  ObjcViewController.m
//  DependencyManager
//
//  Created by Michael Vorontsov on 15/10/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

#import "DetailsViewController.h"
#import "TextService.h"
//#import "DM"

@interface DetailsViewController ()
    @property (weak, nonatomic) IBOutlet UILabel *labelView;
    @property (strong, nonatomic) DMDependencyManager *manager;
@end

@implementation DetailsViewController
    
    - (DMDependencyManager *)manager {
        if (nil == _manager) {
            _manager = [DMDependencyManager shared];
        }
        return _manager;
    }
    
- (TextService*) textService {
    if (nil == _textService) {
        _textService = [self.manager resolveTextService];
//        _textService = [DMDepe]
    }
    return _textService;
}
    
    
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (nil != self.key ) {
        NSString *text = [self.textService textForString: self.key];
        if (text != nil) {
            self.labelView.text = text;
        }
        else {
            self.labelView.text = [NSString stringWithFormat: @"Can't retrive text for \"%@!\"", self.key];
        }
    }
    else {
        self.labelView.text = @"No key found!";
    }
}



@end
