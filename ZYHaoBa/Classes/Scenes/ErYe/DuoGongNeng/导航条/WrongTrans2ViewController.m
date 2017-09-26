//
//  WrongTrans2ViewController.m
//  allinone
//
//  Created by Johnil on 16/2/25.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import "WrongTrans2ViewController.h"
#import "WrongTrans3ViewController.h"

@implementation WrongTrans2ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // configure appearance
    [self configureTranslucentAppearance];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)configureTranslucentAppearance {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTranslucent:YES];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    WrongTrans3ViewController *trans3 = [[WrongTrans3ViewController alloc] init];
    [self.navigationController pushViewController:trans3 animated:YES];
}

@end
