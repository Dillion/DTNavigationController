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

- (UIView *)navigationView
{
    return objc_getAssociatedObject(self, NavigationViewKey);
}

- (void)setNavigationView:(UIView *)navigationView
{
    objc_setAssociatedObject(self, NavigationViewKey, navigationView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
