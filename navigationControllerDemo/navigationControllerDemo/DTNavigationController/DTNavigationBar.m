//
//  DTNavigationBar.m
//  navigationControllerDemo
//
//  Created by Dillion on 1/16/15.
//  Copyright (c) 2015 Dillion. All rights reserved.
//

#import "DTNavigationBar.h"

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

@end
