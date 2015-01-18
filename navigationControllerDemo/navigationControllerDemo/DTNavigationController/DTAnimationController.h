//
//  DTAnimationController.h
//  navigationcontroller
//
//  Created by Dillion on 1/14/15.
//  Copyright (c) 2015 Dillion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static const CGFloat kTransitionAnimationDuration = 0.25f;

typedef NS_ENUM(NSUInteger, AnimationType) {
    TypeNone,
    Push,
    Pop,
    PopToView,
    PopToRoot,
    Show,
};

@interface DTAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic) AnimationType animationType;
@property (nonatomic, copy) void (^completionBlock)(void);

@property (nonatomic, weak) CALayer *navigationLayer;

// for some reason we need to manually reset changes after our custom interaction controller has called cancelInteractiveTransition on the transitioningcontext (ohgodwhy)
- (void)resetAnimation:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
