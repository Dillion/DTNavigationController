//
//  DTAnimationController.m
//  navigationcontroller
//
//  Created by Dillion on 1/14/15.
//  Copyright (c) 2015 Dillion. All rights reserved.
//

#import "DTAnimationController.h"
#import "DTNavigationBar.h"
#import "UIViewController+DTNavigationItems.h"

@implementation DTAnimationController

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return kTransitionAnimationDuration;
}

//  the from context is always the reference
//  rely on the cancelled flag to set completion state
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    DTNavigationBar *navigationBar = (DTNavigationBar *)fromViewController.navigationController.navigationBar;
    self.navigationLayer = navigationBar.layer;
    
    NSDictionary *toInfo = @{@"type": @(_animationType),
                             @"frame":[NSValue valueWithCGRect:fromViewController.view.bounds],
                             @"direction":UITransitionContextToViewControllerKey};
    NSDictionary *fromInfo = @{@"type": @(_animationType),
                               @"frame":[NSValue valueWithCGRect:fromViewController.view.bounds],
                               @"direction":UITransitionContextFromViewControllerKey};
    
    switch (_animationType) {
        case Push:
        case Show: {
            [[transitionContext containerView] addSubview:toViewController.view];
        }
            break;
        case Pop:
        case PopToView:
        case PopToRoot: {
            [[transitionContext containerView] insertSubview:toViewController.view belowSubview:fromViewController.view];
        }
            break;
            
        default:
            break;
    }
    
    [toViewController prepareForTransitionWithInfo:toInfo];
    [fromViewController prepareForTransitionWithInfo:fromInfo];
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [toViewController performTransitionWithInfo:toInfo];
        [fromViewController performTransitionWithInfo:fromInfo];
        
    } completion:^(BOOL finished) {
        
        BOOL cancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!cancelled];
        if (!cancelled) {
            self.navigationLayer = nil;
            [navigationBar updateNavigationBarWithView:fromViewController.navigationView
                                               andView:toViewController.navigationView];
            [toViewController completeTransitionWithInfo:toInfo];
        }
        
    }];
}

@end
