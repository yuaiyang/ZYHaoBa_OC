//
//  ZYTabBarController.m
//  ZYHaoBa
//
//  Created by ylcf on 16/8/11.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYTabBarController.h"
#import "ZYShouYeViewController.h"
#import "ZYErYeViewController.h"
#import "ZYSanYeViewController.h"
#import "ZYSiYeViewController.h"
#import "ZYNavigationController.h"

@interface ZYTabBarController ()<UITabBarControllerDelegate>

@end

@implementation ZYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadRootView];
}

#pragma mark- 四个主页面
- (void)loadRootView {
    ZYShouYeViewController * shouVC = [[ZYShouYeViewController alloc] init];
    ZYNavigationController * shouNC = [[ZYNavigationController alloc] initWithRootViewController:shouVC];
    //设置导航控制器
    shouNC.tabBarItem.title = @"视频";
    shouNC.tabBarItem.image = [UIImage imageNamed:@"iconfont-shipin"];
    // 设置选中图片
    UIImage * selectedImage = [UIImage imageNamed:@"iconfont-ency"];

    // 声明这张图片用原图(别渲染)
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    // 设置角标数字
    shouNC.tabBarItem.badgeValue = @"10";
    shouNC.tabBarItem.selectedImage = selectedImage;
    
    shouNC.navigationBar.translucent = NO;//不透明
    shouNC.navigationBar.barTintColor = [UIColor greenColor];
    
    shouNC.navigationBar.barStyle=UIBarStyleBlackOpaque;
    
    ZYErYeViewController * erYeVC = [[ZYErYeViewController alloc] init];
    UINavigationController * erYeNC = [[UINavigationController alloc] initWithRootViewController:erYeVC];
    //设置导航控制器
    erYeNC.tabBarItem.title = @"图书";
    erYeNC.tabBarItem.image = [UIImage imageNamed:@"iconfont-ency"];
    erYeNC.navigationBar.translucent = YES;//透明
    erYeNC.navigationBar.barTintColor = ZYMAINCOLOER;
    
    erYeNC.navigationBar.barStyle=UIBarStyleBlackOpaque;
    
    ZYSanYeViewController * sanVC = [[ZYSanYeViewController alloc] init];
    UINavigationController * sanNC = [[UINavigationController alloc] initWithRootViewController:sanVC];
    //设置导航控制器
    sanNC.tabBarItem.title = @"功能目录";
    sanNC.tabBarItem.image = [UIImage imageNamed:@"iconfont-news"];
    sanNC.navigationBar.translucent = NO;//不透明
    sanNC.navigationBar.barTintColor = ZYMAINCOLOER;
    
    sanNC.navigationBar.barStyle=UIBarStyleBlackOpaque;
    
    ZYSiYeViewController * siYeVC = [[ZYSiYeViewController alloc] init];
    UINavigationController * siYeNC = [[UINavigationController alloc] initWithRootViewController:siYeVC];
    //设置导航控制器
    siYeNC.tabBarItem.title = @"我的";
    siYeNC.tabBarItem.image = [UIImage imageNamed:@"iconfont-myself"];
    siYeNC.navigationBar.translucent = YES;//透明
    siYeNC.navigationBar.barTintColor = [UIColor redColor];
    
    siYeNC.navigationBar.barStyle=UIBarStyleBlackOpaque;
    // 设置角标数字
    siYeNC.tabBarItem.badgeValue = @"100000";
    
    self.tabBar.translucent = NO;//不透明
    // 设置UITabBarItem选中时的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    // 设置UITabBarItem文字位置
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    
    self.viewControllers = @[shouNC , erYeNC , sanNC , siYeNC];
    
    self.tabBar.tintColor = ZYMAINCOLOER;
    
}

#pragma mark - 拦截点击的是哪一个主控制器
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

////当前viewcontroller支持哪些转屏方向
//
//-(NSUInteger)supportedInterfaceOrientations{
//    
//    return UIInterfaceOrientationMaskPortrait;
//}

@end
