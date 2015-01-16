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
    self.transform = CGAffineTransformMakeTranslation(0, -(kDTNavigationBarHeightAdjustment));
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize barSize = [super sizeThatFits:size];
    defaultHeight = barSize.height;
    barSize.height += kDTNavigationBarHeightAdjustment;
    
    return barSize;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj respondsToSelector:@selector(barStyle)]) {
            UIView *view = (UIView *)obj;
            CGRect frameRect = view.frame;
            frameRect.size.height = defaultHeight + kDTNavigationBarHeightAdjustment;
            view.frame = frameRect;
        }
    }];
}

@end
