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

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    DTNavigationBar *navigationBar = (DTNavigationBar *)fromViewController.navigationController.navigationBar;
    self.navigationLayer = navigationBar.layer;
    
    switch (_animationType) {
        case Push:
        case Show: {
            NSDictionary *toInfo = @{@"frame":[NSValue valueWithCGRect:fromViewController.view.bounds],
                                     @"direction":UITransitionContextToViewControllerKey};
            NSDictionary *fromInfo = @{@"frame":[NSValue valueWithCGRect:fromViewController.view.bounds],
                                       @"direction":UITransitionContextFromViewControllerKey};
            
            [[transitionContext containerView] addSubview:toViewController.view];
            
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
            break;
        case Pop:
        case PopToView:
        case PopToRoot: {
            NSDictionary *toInfo = @{@"frame":[NSValue valueWithCGRect:fromViewController.view.bounds],
                                     @"direction":UITransitionContextToViewControllerKey};
            NSDictionary *fromInfo = @{@"frame":[NSValue valueWithCGRect:fromViewController.view.bounds],
                                       @"direction":UITransitionContextFromViewControllerKey};
            
            [[transitionContext containerView] insertSubview:toViewController.view belowSubview:fromViewController.view];
            
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
            break;
            
        default:
            break;
    }
}

- (void)resetAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [fromViewController cancelTransition];
}

@end
