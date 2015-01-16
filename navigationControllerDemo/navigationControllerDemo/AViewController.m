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

@interface AViewController ()

@end

@implementation AViewController

//- (void)loadView
//{
//    self.navigationView = [[UIView alloc] init];
//    self.navigationView.backgroundColor = [UIColor orangeColor];
//    self.navigationView.translatesAutoresizingMaskIntoConstraints = NO;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationView = [[NavigationView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
