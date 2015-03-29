//
//  DTNavigationController.m
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

#import "DTNavigationController.h"
#import "DTToolbar.h"
#import "DTNavigationBar.h"
#import "UIViewController+DTNavigationItems.h"
#import "DTAnimationController.h"
#import "DTInteractionController.h"

@interface DTNavigationController ()
@property (nonatomic, strong) DTAnimationController *animationController;
@property (nonatomic, strong) DTInteractionController *interactionController;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *popGestureRecognizer;
@end

@implementation DTNavigationController

#pragma mark - Lifecycle

- (DTNavigationController *)commonInitWithControllers:(NSArray *)controllers
{
    DTNavigationController *navigationController = [[DTNavigationController alloc] initWithNavigationBarClass:[DTNavigationBar class] toolbarClass:[DTToolbar class]];
    [navigationController setViewControllers:controllers];
    
    return navigationController;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    return [self commonInitWithControllers:@[rootViewController]];
}

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    if ([self.navigationBar isKindOfClass:[UINavigationBar class]]) {
        return [self commonInitWithControllers:[self viewControllers]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    
    self.animationController = [[DTAnimationController alloc] init];
    self.interactionController = [[DTInteractionController alloc] init];
    _interactionController.animationController = self.animationController;
    
    self.popGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    _popGestureRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:_popGestureRecognizer];
}

#pragma mark - Navigation Controller Delegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    
    return _animationController;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    if (_interactive) {
        return _interactionController;
    }
    return nil;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    DTNavigationBar *navigationBar = (DTNavigationBar *)navigationController.navigationBar;
    
    if (![navigationBar isShowingNavigationView]) {
        [navigationBar updateNavigationBarWithView:nil
                                           andView:viewController.navigationView];
    }
}

#pragma mark - Navigation Controller overrides

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    _animationController.animationType = Push;
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    _animationController.animationType = Pop;
    return [super popViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    _animationController.animationType = PopToView;
    return [super popToViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    _animationController.animationType = PopToRoot;
    return [super popToRootViewControllerAnimated:animated];
}

- (void)showViewController:(UIViewController *)viewController sender:(id)sender
{
    _animationController.animationType = Show;
    [super showViewController:viewController sender:sender];
}

#pragma mark - Pop Gesture Recognizer

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGestureRecognizer
{
    CGPoint location = [panGestureRecognizer locationInView:self.view];
    CGFloat fraction = location.x/self.view.bounds.size.width;
    
    switch (panGestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            _interactive = YES;
            self.reverseViewOrder = YES;
            [self popViewControllerAnimated:YES];
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            [_interactionController updateInteractiveTransition:fraction];
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            if (fraction >= 0.3) {
                [_interactionController finishInteractiveTransition];
            }
            else {
                [_interactionController cancelInteractiveTransition];
            }
            _interactive = NO;
            break;
        }
        case UIGestureRecognizerStateCancelled:
        {
            [_interactionController cancelInteractiveTransition];
            _interactive = YES;
            break;
        }
        default:
            break;
    }
}

#pragma mark - Getters and Setters

- (void)setReverseViewOrder:(BOOL)reverseViewOrder
{
    _animationController.reverseViewOrder = reverseViewOrder;
}

- (BOOL)reverseViewOrder
{
    return _animationController.reverseViewOrder;
}

- (void)setAnimationDuration:(CGFloat)animationDuration
{
    _animationController.animationDuration = animationDuration;
}

- (CGFloat)animationDuration
{
    return _animationController.animationDuration;
}

@end
