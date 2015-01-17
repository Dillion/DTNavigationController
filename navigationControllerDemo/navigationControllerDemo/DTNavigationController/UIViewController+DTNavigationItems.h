//
//  UIViewController+DTNavigationItems.h
//  navigationControllerDemo
//
//  Created by Dillion on 1/16/15.
//  Copyright (c) 2015 Dillion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTNavigationView.h"

@interface UIViewController (DTNavigationItems)

@property (nonatomic, strong) DTNavigationView *navigationView;

- (void)prepareForAnimation;
- (void)performAnimation;
- (void)onAnimationCompleted;

@end
