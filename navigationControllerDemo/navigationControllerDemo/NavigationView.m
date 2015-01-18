//
//  NavigationView.m
//  navigationControllerDemo
//
//  Created by Dillion on 1/17/15.
//  Copyright (c) 2015 Dillion. All rights reserved.
//

#import "NavigationView.h"

@implementation NavigationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)commonInit
{
    UIView *view = [[[UINib nibWithNibName:@"NavigationView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
    view.frame = self.bounds;
    [self addSubview:view];
    
    // can't add constraints to navigation bar ... so let's use autoresizing masks instead to fill to the edges
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
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

@end
