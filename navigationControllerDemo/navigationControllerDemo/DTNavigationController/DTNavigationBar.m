//
//  DTNavigationBar.m
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

#import "DTNavigationBar.h"
#import "DTNavigationView.h"

@implementation DTNavigationBar

#pragma mark - Lifecycle

- (void)commonInit
{
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:[UIImage new]];
    self.translucent = YES;
}

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

#pragma mark - Getters and Setters

- (void)setNavigationBarHeight:(CGFloat)navigationBarHeight
{
    _navigationBarHeight = navigationBarHeight;
    [self sizeToFit];
}

#pragma mark - Layout

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize barSize = [super sizeThatFits:size];
    if (_navigationBarHeight > 0) {
        barSize.height = _navigationBarHeight;
    }
    return barSize;
}

- (void)addSubview:(UIView *)view
{
    if (![view isKindOfClass:[DTNavigationView class]]) {
        view.hidden = YES;
    }
    [super addSubview:view];
}

- (void)updateNavigationBarFromView:(DTNavigationView *)currentNavigationView
                            toView:(DTNavigationView *)incomingNavigationView
{
    if (currentNavigationView != incomingNavigationView) {
        [currentNavigationView removeFromSuperview];
        [self addSubview:incomingNavigationView];
    }
    
    _isShowingNavigationView = YES;
}

@end
