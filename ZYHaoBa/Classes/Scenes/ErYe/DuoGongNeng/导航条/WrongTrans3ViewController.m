//
//  WrongTrans3ViewController.m
//  allinone
//
//  Created by Johnil on 16/2/25.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import "WrongTrans3ViewController.h"

@implementation WrongTrans3ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // configure appearance
    [self restoreDefaultAppearance];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)restoreDefaultAppearance {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor grayColor]];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor grayColor]];
    [self.navigationController.navigationBar setShadowImage:nil];
    [self.navigationController.navigationBar setTranslucent:NO];
}

@end
