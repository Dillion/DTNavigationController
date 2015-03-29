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

@interface BViewController ()

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NavigationView *navigationView = [[NavigationView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    navigationView.backgroundColor = [UIColor grayColor];
    [navigationView.navigationButton addTarget:self action:@selector(onBackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView.navigationButton showMenu:YES animated:NO];
//    navigationView.hidden = YES;
    self.navigationView = navigationView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onBackButtonPressed:(id)sender
{
    DTNavigationController *navigationController = (DTNavigationController *)self.navigationController;
    navigationController.reverseViewOrder = YES;
    [navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[self transitionCoordinator] animateAlongsideTransitionInView:self.navigationView animation:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        UIViewController *controller = [context viewControllerForKey:UITransitionContextToViewControllerKey];
        if ([controller isKindOfClass:[AViewController class]]) {
            NavigationView *navigationView = (NavigationView *)self.navigationView;
            [navigationView.navigationButton showMenu:NO animated:YES];
        }
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
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

@end
