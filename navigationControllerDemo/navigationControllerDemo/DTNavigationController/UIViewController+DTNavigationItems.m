//
//  UIViewController+DTNavigationItems.m
//  navigationControllerDemo
//
//  Created by Dillion on 1/16/15.
//  Copyright (c) 2015 Dillion. All rights reserved.
//

#import "UIViewController+DTNavigationItems.h"
#import <objc/runtime.h>
#import "DTAnimationController.h"

static char const *const NavigationViewKey = "NavigationViewKey";

@implementation UIViewController (DTNavigationItems)

- (DTNavigationView *)navigationView
{
    return objc_getAssociatedObject(self, NavigationViewKey);
}

- (void)setNavigationView:(DTNavigationView *)navigationView
{
    objc_setAssociatedObject(self, NavigationViewKey, navigationView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)prepareForTransitionWithInfo:(NSDictionary *)info
{
    CGRect frameRect = [[info objectForKey:@"frame"] CGRectValue];
    AnimationType animationType = [[info objectForKey:@"type"] unsignedIntegerValue];
    
    switch (animationType) {
        case Push:
        case Show: {
            if ([[info objectForKey:@"direction"] isEqualToString:UITransitionContextFromViewControllerKey]) {
            } else {
                frameRect.origin.x = frameRect.size.width;
                self.view.frame = frameRect;
            }
        }
            break;
        case Pop:
        case PopToView:
        case PopToRoot: {
            if ([[info objectForKey:@"direction"] isEqualToString:UITransitionContextFromViewControllerKey]) {
            } else {
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)performTransitionWithInfo:(NSDictionary *)info
{
    CGRect frameRect = [[info objectForKey:@"frame"] CGRectValue];
    AnimationType animationType = [[info objectForKey:@"type"] unsignedIntegerValue];
    
    switch (animationType) {
        case Push:
        case Show: {
            if ([[info objectForKey:@"direction"] isEqualToString:UITransitionContextFromViewControllerKey]) {
            } else {
                frameRect.origin.x = 0;
                self.view.frame = frameRect;
            }
        }
            break;
        case Pop:
        case PopToView:
        case PopToRoot: {
            if ([[info objectForKey:@"direction"] isEqualToString:UITransitionContextFromViewControllerKey]) {
                frameRect.origin.x = frameRect.size.width;
                self.view.frame = frameRect;
            } else {
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)completeTransitionWithInfo:(NSDictionary *)info
{
    CGRect frameRect = [[info objectForKey:@"frame"] CGRectValue];
    AnimationType animationType = [[info objectForKey:@"type"] unsignedIntegerValue];
    
    switch (animationType) {
        case Push:
        case Show: {
            if ([[info objectForKey:@"direction"] isEqualToString:UITransitionContextFromViewControllerKey]) {
            } else {
                frameRect.origin.x = 0;
                self.view.frame = frameRect;
            }
        }
            break;
        case Pop:
        case PopToView:
        case PopToRoot: {
            if ([[info objectForKey:@"direction"] isEqualToString:UITransitionContextFromViewControllerKey]) {
                frameRect.origin.x = frameRect.size.width;
                self.view.frame = frameRect;
            } else {
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)cancelTransition
{
    
}

@end
