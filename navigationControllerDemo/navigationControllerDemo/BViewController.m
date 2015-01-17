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

@interface BViewController ()

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationView = [[NavigationView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
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

@end
