//
//  ViewController.m
//  navigationControllerDemo
//
//  Created by Dillion on 1/15/15.
//  Copyright (c) 2015 Dillion. All rights reserved.
//

#import "AViewController.h"
#import "UIViewController+DTNavigationItems.h"
#import "NavigationView.h"
#import "BViewController.h"
#import "HamburgerButton.h"

@interface AViewController ()

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationView = [[NavigationView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
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

- (void)prepareForTransitionWithInfo:(NSDictionary *)info
{
    if ([[info objectForKey:@"direction"] isEqualToString:UITransitionContextFromViewControllerKey]) {
    } else {
    }
}

- (void)performTransitionWithInfo:(NSDictionary *)info
{
    if ([[info objectForKey:@"direction"] isEqualToString:UITransitionContextFromViewControllerKey]) {
        NavigationView *navigationView = (NavigationView *)self.navigationView;
        [navigationView.navigationButton showMenu:YES animated:YES];
    } else {
    }
}

- (void)completeTransitionWithInfo:(NSDictionary *)info
{
    if ([[info objectForKey:@"direction"] isEqualToString:UITransitionContextFromViewControllerKey]) {
        
    } else {
        NavigationView *navigationView = (NavigationView *)self.navigationView;
        [navigationView.navigationButton showMenu:NO animated:NO];
    }
}

- (void)cancelTransition
{
    
}

@end
