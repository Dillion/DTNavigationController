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
#import "navigationControllerDemo-Swift.h"

@interface BViewController () <NavigationViewAnimating>

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NavigationView *navigationView = [[NavigationView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    navigationView.animationDelegate = self;
    [navigationView.navigationButton addTarget:self action:@selector(onBackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)performAnimation
{
    NavigationView *navigationView = (NavigationView *)self.navigationView;
    navigationView.navigationButton.showsMenu = YES;
}

@end
