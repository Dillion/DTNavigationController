//
//  BViewController.m
//  navigationControllerDemo
//
//  Created by Dillion on 1/16/15.
//  Copyright (c) 2015 Dillion. All rights reserved.
//

#import "BViewController.h"
#import "NavigationView.h"
#import "HamburgerButton.h"
#import "AViewController.h"

#import "DTNavigation.h"
#import "PopAnimationController.h"

@interface BViewController () <UINavigationControllerDelegate>
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *popGestureRecognizer;
@property (nonatomic, strong) PopAnimationController *animationController;
@property (nonatomic, strong) DTInteractionController *interactionController;
@property (nonatomic) BOOL interactive;

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NavigationView *navigationView = [[NavigationView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    navigationView.backgroundColor = [UIColor grayColor];
    [navigationView.navigationButton addTarget:self action:@selector(onBackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView.navigationButton showMenu:YES animated:NO];
    self.navigationView = navigationView;
    
    self.popGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    _popGestureRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:_popGestureRecognizer];
    
    self.animationController = [[PopAnimationController alloc] init];
    self.interactionController = [[DTInteractionController alloc] initWithAnimationController:_animationController decorationLayer:self.navigationController.navigationBar.layer];
}

- (void)onBackButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.delegate = nil;
    
    [[self transitionCoordinator] animateAlongsideTransitionInView:self.navigationView animation:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        UIViewController *controller = [context viewControllerForKey:UITransitionContextToViewControllerKey];
        if ([controller isKindOfClass:[AViewController class]]) {
            NavigationView *navigationView = (NavigationView *)self.navigationView;
            [navigationView.navigationButton showMenu:NO animated:YES];
        }
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        UIViewController *controller = [context viewControllerForKey:UITransitionContextToViewControllerKey];
        DTNavigationBar *navigationBar = (DTNavigationBar *)controller.navigationController.navigationBar;
        if (![context isCancelled] && [controller isKindOfClass:[AViewController class]]) {
            [navigationBar updateNavigationBarFromView:self.navigationView toView:controller.navigationView];
        }
    }];
    
    [[self transitionCoordinator] notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        UIViewController *controller = [context viewControllerForKey:UITransitionContextFromViewControllerKey];
        if ([context isCancelled] && [controller isKindOfClass:[self class]]) {
            self.view.frame = self.view.bounds;
        
            NavigationView *navigationView = (NavigationView *)self.navigationView;
            [navigationView.navigationButton showMenu:YES animated:NO];
        }
    }];
}


#pragma mark - Pop Gesture Recognizer

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGestureRecognizer
{
    CGPoint location = [panGestureRecognizer locationInView:self.view];
    CGPoint origin = self.view.frame.origin;
    CGFloat fraction = (location.x + origin.x)/self.view.bounds.size.width;
    
    DTNavigationController *navigationController = (DTNavigationController *)self.navigationController;
    
    switch (panGestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            _interactive = YES;
            [navigationController popViewControllerAnimated:YES];
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

#pragma mark - Navigation Controller Delegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    
    return _interactionController.animationController;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    if (_interactive) {
        return _interactionController;
    }
    return nil;
}

@end
