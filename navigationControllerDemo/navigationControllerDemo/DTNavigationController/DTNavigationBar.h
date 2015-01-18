//
//  DTNavigationBar.h
//  navigationControllerDemo
//
//  Created by Dillion on 1/16/15.
//  Copyright (c) 2015 Dillion. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DTNavigationView;

static const CGFloat kDTNavigationBarHeightAdjustment = 40.0f;

@interface DTNavigationBar : UINavigationBar

@property (nonatomic, assign, readonly) BOOL isShowingNavigationView;

- (void)updateNavigationBarWithView:(DTNavigationView *)currentNavigationView
                            andView:(DTNavigationView *)incomingNavigationView;

@end
