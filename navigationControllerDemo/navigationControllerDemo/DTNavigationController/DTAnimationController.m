//
//  DTAnimationController.m
//
//  Copyright (c) 2015 Dillion. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "DTAnimationController.h"
#import "DTNavigationBar.h"
#import "UIViewController+DTNavigationItems.h"
#import "DTTransitionKeys.h"

@implementation DTAnimationController

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.animationDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    DTNavigationBar *navigationBar = (DTNavigationBar *)fromViewController.navigationController.navigationBar;
    if (!navigationBar) navigationBar = (DTNavigationBar *)toViewController.navigationController.navigationBar;
    _navigationLayer = navigationBar.layer;
    
    NSDictionary *toInfo = @{kDTTransitionType: @(_animationType),
                             kDTTransitionFrame:[NSValue valueWithCGRect:fromViewController.view.bounds],
                             kDTTransitionDirection:UITransitionContextToViewControllerKey,
                             kDTTransitionDuration:@(duration),
                             kDTTransitionFromClass:NSStringFromClass([fromViewController class]),
                             kDTTransitionToClass:NSStringFromClass([toViewController class])};
    NSDictionary *fromInfo = @{kDTTransitionType: @(_animationType),
                               kDTTransitionFrame:[NSValue valueWithCGRect:fromViewController.view.bounds],
                               kDTTransitionDirection:UITransitionContextFromViewControllerKey,
                               kDTTransitionDuration:@(duration),
                               kDTTransitionFromClass:NSStringFromClass([fromViewController class]),
                               kDTTransitionToClass:NSStringFromClass([toViewController class])};
    
    switch (_animationType) {
        case Push:
        case Show: {
            if (_reverseViewOrder) {
                [[transitionContext containerView] insertSubview:toViewController.view belowSubview:fromViewController.view];
            } else {
                [[transitionContext containerView] addSubview:toViewController.view];
            }
        }
            break;
        case Pop:
        case PopToView:
        case PopToRoot: {
            if (_reverseViewOrder) {
                [[transitionContext containerView] insertSubview:toViewController.view belowSubview:fromViewController.view];
            } else {
                [[transitionContext containerView] addSubview:toViewController.view];
            }
        }
            break;
            
        default:
            break;
    }
    
    [toViewController dt_prepareForTransitionWithInfo:toInfo];
    [fromViewController dt_prepareForTransitionWithInfo:fromInfo];
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [toViewController dt_performTransitionWithInfo:toInfo];
        [fromViewController dt_performTransitionWithInfo:fromInfo];
        
    } completion:^(BOOL finished) {
        
        BOOL cancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!cancelled];
        if (!cancelled) {
            _navigationLayer = nil;
            [navigationBar updateNavigationBarWithView:fromViewController.navigationView
                                               andView:toViewController.navigationView];
            [fromViewController dt_completeTransitionWithInfo:fromInfo];
            [toViewController dt_completeTransitionWithInfo:toInfo];
        }
        
    }];
}

- (CGFloat)animationDuration
{
    if (_animationDuration <= 0) {
        // TODO: add runtime warning here
        return kTransitionAnimationDuration;
    }
    return _animationDuration;
}

@end
