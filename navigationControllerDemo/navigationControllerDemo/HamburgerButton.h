//
//  HamburgerButton.h
//  navigationControllerDemo
//
//  Created by Dillion on 1/17/15.
//  Copyright (c) 2015 Dillion. All rights reserved.
//
//  This is a port of Arkadiusz Holko's HamburgerButton in Swift https://github.com/fastred/HamburgerButton

#import <UIKit/UIKit.h>

@interface HamburgerButton : UIButton

@property (nonatomic, strong) UIColor *lineColor;

- (void)showMenu:(BOOL)show
        animated:(BOOL)animated;

@end
