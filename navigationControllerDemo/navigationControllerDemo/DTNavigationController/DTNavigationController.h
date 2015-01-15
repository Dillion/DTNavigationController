//
//  DTNavigationController.h
//  navigationcontroller
//
//  Created by Dillion on 1/14/15.
//  Copyright (c) 2015 Dillion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTAnimationController.h"

@interface DTNavigationController : UINavigationController <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) DTAnimationController *animationController;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *popGestureRecognizer;
@property (nonatomic) BOOL interactive;

@end