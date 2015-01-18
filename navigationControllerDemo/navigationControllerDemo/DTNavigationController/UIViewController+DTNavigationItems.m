//
//  UIViewController+DTNavigationItems.m
//  navigationControllerDemo
//
//  Created by Dillion on 1/16/15.
//  Copyright (c) 2015 Dillion. All rights reserved.
//

#import "UIViewController+DTNavigationItems.h"
#import <objc/runtime.h>

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
    
}

- (void)performTransitionWithInfo:(NSDictionary *)info
{
    
}

- (void)completeTransitionWithInfo:(NSDictionary *)info
{
    
}

- (void)cancelTransition
{
    
}

@end
