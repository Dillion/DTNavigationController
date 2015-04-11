//
//  ViewController.m
//  navigationControllerDemo
//
//  Created by Dillion on 1/15/15.
//  Copyright (c) 2015 Dillion. All rights reserved.
//

#import "AViewController.h"
#import "NavigationView.h"
#import "BViewController.h"
#import "HamburgerButton.h"

#import "DTNavigation.h"

@interface AViewController ()

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DTNavigationBar *navigationBar = (DTNavigationBar *)self.navigationController.navigationBar;
    navigationBar.navigationBarHeight = 84.0f;
    
    self.navigationView = [[NavigationView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    [navigationBar updateNavigationBarFromView:nil toView:self.navigationView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onButtonTapped:(id)sender
{
    BViewController *bViewController = [[BViewController alloc] initWithNibName:@"BViewController" bundle:nil];
    [self.navigationController pushViewController:bViewController animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[self transitionCoordinator] animateAlongsideTransitionInView:self.navigationView animation:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        UIViewController *controller = [context viewControllerForKey:UITransitionContextToViewControllerKey];
        if ([controller isKindOfClass:[BViewController class]]) {
            NavigationView *navigationView = (NavigationView *)self.navigationView;
            [navigationView.navigationButton showMenu:YES animated:YES];
        }
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        DTNavigationBar *navigationBar = (DTNavigationBar *)self.navigationController.navigationBar;
        UIViewController *controller = [context viewControllerForKey:UITransitionContextToViewControllerKey];
        if ([controller isKindOfClass:[BViewController class]]) {
            [navigationBar updateNavigationBarFromView:self.navigationView toView:controller.navigationView];
            NavigationView *navigationView = (NavigationView *)self.navigationView;
            [navigationView.navigationButton showMenu:NO animated:NO];
        }
    }];
}

@end
