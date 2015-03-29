//
//  UIViewController+DTNavigationItems.h
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

#import <UIKit/UIKit.h>
#import "DTNavigationView.h"

@interface UIViewController (DTNavigationItems)

@property (nonatomic, strong) DTNavigationView *navigationView; // Custom view added to the navigation bar of a UINavigationController

/**
 *  Override this to customize appearance before transition animation occurs.
 *
 *  @param info A dictionary passed in from -animationTransition identifying the type of transition taking place
 */
- (void)dt_prepareForTransitionWithInfo:(NSDictionary *)info;

/**
 *  Override this to apply the proper transition animation. If there is no change in animatable properties for either the incoming and outgoing view controller, the completion block in -animateTransition gets called immediately, even if there is a non-zero animation duration specified for the animation controller. Always make sure there is animation for at least one view taking place. Another caveat is that the animating view must be contained within the transition context, for other views, use UIViewControllerTransitionCoordinator's -animateAlongsideTransitionInView, or start another UIView animation block and sync the duration to the transition.
 *
 *  @param info A dictionary passed in from -animationTransition identifying the type of transition taking place
 */
- (void)dt_performTransitionWithInfo:(NSDictionary *)info;

/**
 *  Override this to customize appearance after transition animation occurs.
 *
 *  @param info A dictionary passed in from -animationTransition identifying the type of transition taking place
 */
- (void)dt_completeTransitionWithInfo:(NSDictionary *)info;

@end
