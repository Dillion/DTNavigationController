//
//  BViewController.m
//  navigationControllerDemo
//
//  Created by Dillion on 1/16/15.
//  Copyright (c) 2015 Dillion. All rights reserved.
//

#import "BViewController.h"
#import "UIViewController+DTNavigationItems.h"
#import "NavigationView.h"
#import "HamburgerButton.h"
#import "DTAnimationController.h"

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

- (void)commonInit
{
    UIView *view = [[[UINib nibWithNibName:@"BViewController" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
    view.frame = self.view.bounds;
    [self.view addSubview:view];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)onBackButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)performTransitionWithInfo:(NSDictionary *)info
{
    [super performTransitionWithInfo:info];

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
                NavigationView *navigationView = (NavigationView *)self.navigationView;
                [navigationView.navigationButton showMenu:NO animated:YES];
            } else {
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)cancelTransition
{
    self.view.frame = self.view.bounds;
    
    NavigationView *navigationView = (NavigationView *)self.navigationView;
    [navigationView.navigationButton showMenu:YES animated:YES];
}

@end
