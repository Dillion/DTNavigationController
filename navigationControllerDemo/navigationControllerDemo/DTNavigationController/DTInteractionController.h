//
//  DTInteractionController.h
//  navigationControllerDemo
//
//  Created by Dillion on 1/18/15.
//  Copyright (c) 2015 Dillion. All rights reserved.
//
//  This class is based heavily off ECPercentDrivenInteractiveTransition from https://github.com/ECSlidingViewController/ECSlidingViewController

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DTAnimationController.h"

@interface DTInteractionController : NSObject <UIViewControllerInteractiveTransitioning>

@property (nonatomic, assign) DTAnimationController *animationController;

@property (nonatomic, assign, readonly) CGFloat percentComplete;

- (void)updateInteractiveTransition:(CGFloat)percentComplete;
- (void)cancelInteractiveTransition;
- (void)finishInteractiveTransition;

@end
