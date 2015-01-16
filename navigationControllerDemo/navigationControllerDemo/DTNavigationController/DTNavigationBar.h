//
//  DTNavigationBar.h
//  navigationControllerDemo
//
//  Created by Dillion on 1/16/15.
//  Copyright (c) 2015 Dillion. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NavigationView;

static const CGFloat kDTNavigationBarHeightAdjustment = 40.0f;

@interface DTNavigationBar : UINavigationBar

@property (nonatomic, weak) NavigationView *currentNavigationView;

- (void)animateTransitionForNavigationView:(UIView *)fromView toNavigationView:(UIView *)toView;
- (void)updateInteractiveTransition:(CGFloat)percentComplete;
- (void)finishInteractiveTransition;
- (void)cancelInteractiveTransition;

@end
