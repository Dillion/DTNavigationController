//
//  NavigationView.h
//  navigationControllerDemo
//
//  Created by Dillion on 1/17/15.
//  Copyright (c) 2015 Dillion. All rights reserved.
//

#import "DTNavigationView.h"

@interface NavigationView : DTNavigationView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descripLabel;
@property (weak, nonatomic) IBOutlet UIView *iconView;
@property (weak, nonatomic) IBOutlet UIButton *navigationButton;

@end
