//
//  DTNavigationController.m
//  navigationcontroller
//
//  Created by Dillion on 1/14/15.
//  Copyright (c) 2015 Dillion. All rights reserved.
//

#import "DTNavigationController.h"
#import "DTToolbar.h"
#import "DTNavigationBar.h"
#import "UIViewController+DTNavigationItems.h"
#import "DTAnimationController.h"
#import "DTInteractionController.h"

@interface DTNavigationController ()

@end

@implementation DTNavigationController

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

- (DTNavigationController *)commonInitWithControllers:(NSArray *)controllers
{
    DTNavigationController *navigationController = [[DTNavigationController alloc] initWithNavigationBarClass:[DTNavigationBar class] toolbarClass:[DTToolbar class]];
    [navigationController setViewControllers:controllers];
    
    return navigationController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    
    self.animationController = [[DTAnimationController alloc] initWithCompletionBlock:^{
        
    }];
    self.interactionController = [[DTInteractionController alloc] init];
    _interactionController.animationController = self.animationController;
    
    self.popGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    _popGestureRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:_popGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
            self.interactive = YES;
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
            self.interactive = NO;
            break;
        }
        case UIGestureRecognizerStateCancelled:
        {
            [_interactionController cancelInteractiveTransition];
            self.interactive = YES;
            break;
        }
        default:
            break;
    }
}

@end
