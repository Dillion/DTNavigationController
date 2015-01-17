//
//  DTNavigationBar.m
//  navigationControllerDemo
//
//  Created by Dillion on 1/16/15.
//  Copyright (c) 2015 Dillion. All rights reserved.
//

#import "DTNavigationBar.h"
#import "DTNavigationView.h"

@interface DTNavigationBar() {
    CGFloat defaultHeight;
}
@end

@implementation DTNavigationBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize barSize = [super sizeThatFits:size];
    defaultHeight = barSize.height;
    barSize.height += kDTNavigationBarHeightAdjustment;
    
    return barSize;
}

- (void)animateTransitionForNavigationView:(UIView *)fromView toNavigationView:(UIView *)toView
{
    
}

- (void)updateInteractiveTransition:(CGFloat)percentComplete
{
    
}

- (void)finishInteractiveTransition
{
    
}

- (void)cancelInteractiveTransition
{
    
}

- (void)setCurrentNavigationView:(DTNavigationView *)currentNavigationView
{
    if (_currentNavigationView != currentNavigationView) {
        [self hideNativeSubviews];
        [_currentNavigationView removeFromSuperview];
        [self addSubview:currentNavigationView];
    }
    _currentNavigationView = currentNavigationView;
}

// crappy hack to hide the default navigation bar title and bar button items
- (void)hideNativeSubviews
{
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *view = (UIView *)obj;
        if (![view isKindOfClass:[DTNavigationView class]] && [NSStringFromClass([view class]) compare:@"_UINavigationBarBackground"] != NSOrderedSame) {
            view.hidden = YES;
        }
    }];
}

@end
