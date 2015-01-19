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
#import "DTAnimationController.h"

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

- (void)performTransitionWithInfo:(NSDictionary *)info
{
    [super performTransitionWithInfo:info];
    
    AnimationType animationType = [[info objectForKey:@"type"] unsignedIntegerValue];
    
    switch (animationType) {
        case Push:
        case Show: {
            if ([[info objectForKey:@"direction"] isEqualToString:UITransitionContextFromViewControllerKey]) {
                NavigationView *navigationView = (NavigationView *)self.navigationView;
                [navigationView.navigationButton showMenu:YES animated:YES];
            }
        }
            break;
        case Pop:
        case PopToView:
        case PopToRoot: {
        }
            break;
            
        default:
            break;
    }
}

- (void)completeTransitionWithInfo:(NSDictionary *)info
{
    [super completeTransitionWithInfo:info];
    
    AnimationType animationType = [[info objectForKey:@"type"] unsignedIntegerValue];
    
    switch (animationType) {
        case Push:
        case Show: {
        }
            break;
        case Pop:
        case PopToView:
        case PopToRoot: {
            if ([[info objectForKey:@"direction"] isEqualToString:UITransitionContextFromViewControllerKey]) {
            } else {
                NavigationView *navigationView = (NavigationView *)self.navigationView;
                [navigationView.navigationButton showMenu:NO animated:NO];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)cancelTransition
{
    
}

@end
