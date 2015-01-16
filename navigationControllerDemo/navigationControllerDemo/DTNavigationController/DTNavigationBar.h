//
//  DTNavigationBar.h
//  navigationControllerDemo
//
//  Created by Dillion on 1/16/15.
//  Copyright (c) 2015 Dillion. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat kDTNavigationBarHeightAdjustment = 70.0f;

@interface DTNavigationBar : UINavigationBar

- (void)animateTransitionForNavigationView:(UIView *)fromView toNavigationView:(UIView *)toView;
- (void)updateInteractiveTransition:(CGFloat)percentComplete;
- (void)finishInteractiveTransition;
- (void)cancelInteractiveTransition;

@end
