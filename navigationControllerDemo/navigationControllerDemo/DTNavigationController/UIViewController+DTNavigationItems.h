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

// this are the base transition steps applied in animateTransition
// we can use UIViewControllerTransitionCoordinator's -animateAlongsideTransition to further customize the animations
- (void)prepareForTransitionWithInfo:(NSDictionary *)info;
- (void)performTransitionWithInfo:(NSDictionary *)info;
- (void)completeTransitionWithInfo:(NSDictionary *)info;

@end
