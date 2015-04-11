//
//  PopAnimationController.m
//  navigationControllerDemo
//
//  Created by Dillion on 4/10/15.
//  Copyright (c) 2015 Dillion. All rights reserved.
//

#import "PopAnimationController.h"

@implementation PopAnimationController

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [[transitionContext containerView] insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    __block CGRect frameRect = fromViewController.view.bounds;
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        frameRect.origin.x = frameRect.size.width;
        fromViewController.view.frame = frameRect;
        
    } completion:^(BOOL finished) {
        
        BOOL cancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!cancelled];
        if (!cancelled) {
        }
        
    }];
}

@end
