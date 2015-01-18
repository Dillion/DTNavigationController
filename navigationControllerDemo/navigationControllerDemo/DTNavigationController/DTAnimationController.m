//
//  DTAnimationController.m
//  navigationcontroller
//
//  Created by Dillion on 1/14/15.
//  Copyright (c) 2015 Dillion. All rights reserved.
//

#import "DTAnimationController.h"
#import "UIViewController+DTNavigationItems.h"

@implementation DTAnimationController

- (instancetype)initWithCompletionBlock:(void (^)(void))completionBlock
{
    self = [super init];
    if (self) {
        self.completionBlock = completionBlock;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return kTransitionAnimationDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    self.navigationLayer = toViewController.navigationView.layer;
    
    switch (_animationType) {
        case Push:
        case Show: {
            CGRect destBounds = fromViewController.view.bounds;
            destBounds.origin.x = destBounds.size.width;
            toViewController.view.frame = destBounds;
            
            [[transitionContext containerView] addSubview:toViewController.view];
            
            [toViewController performAnimation];
            
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                CGRect newDestRect = CGRectMake(0, destBounds.origin.y, destBounds.size.width, destBounds.size.height);
                toViewController.view.frame = newDestRect;
                
            } completion:^(BOOL finished) {
                
                BOOL cancelled = [transitionContext transitionWasCancelled];
                [transitionContext completeTransition:!cancelled];
                self.navigationLayer = nil;
                if (!cancelled && _completionBlock) {
                    [fromViewController onAnimationCompleted];
                    _completionBlock();
                }
                
            }];
        }
            break;
        case Pop:
        case PopToView:
        case PopToRoot: {
            CGRect destBounds = fromViewController.view.bounds;
            
            [[transitionContext containerView] insertSubview:toViewController.view belowSubview:fromViewController.view];
            
            [toViewController performAnimation];
            
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                CGRect newDestRect = CGRectMake(destBounds.size.width, destBounds.origin.y, destBounds.size.width, destBounds.size.height);
                fromViewController.view.frame = newDestRect;
                
            } completion:^(BOOL finished) {
                
                BOOL cancelled = [transitionContext transitionWasCancelled];
                [transitionContext completeTransition:!cancelled];
                self.navigationLayer = nil;
                if (!cancelled && _completionBlock) {
                    _completionBlock();
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
    
    CGRect viewRect = fromViewController.view.bounds;
    fromViewController.view.frame = viewRect;
}

@end
