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
    None,
    Push,
    Pop,
    PopToView,
    PopToRoot,
    Show,
};

@interface DTAnimationController : UIPercentDrivenInteractiveTransition <UIViewControllerAnimatedTransitioning>

@property (nonatomic) AnimationType animationType;
@property (nonatomic, copy) void (^completionBlock)(void);

- (instancetype)initWithCompletionBlock:(void (^)(void))completionBlock;

@end
