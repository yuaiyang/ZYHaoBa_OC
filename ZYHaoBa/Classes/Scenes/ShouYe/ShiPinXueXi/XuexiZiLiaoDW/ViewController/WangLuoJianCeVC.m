//
//  WangLuoJianCeVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/25.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "WangLuoJianCeVC.h"
#import "Reachability.h"

@interface WangLuoJianCeVC ()
@property (nonatomic, strong) Reachability *conn;
@end

@implementation WangLuoJianCeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
    self.conn = [Reachability reachabilityForInternetConnection];
    [self.conn startNotifier];
}

- (void)dealloc
{
    [self.conn stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)networkStateChange
{
    [self checkNetworkState];
}

// 用WIFI
// [wifi currentReachabilityStatus] != NotReachable
// [conn currentReachabilityStatus] != NotReachable

// 没有用WIFI, 只用了手机网络
// [wifi currentReachabilityStatus] == NotReachable
// [conn currentReachabilityStatus] != NotReachable

// 没有网络
// [wifi currentReachabilityStatus] == NotReachable
// [conn currentReachabilityStatus] == NotReachable

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)checkNetworkState
{
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    // 3.判断网络状态
    if ([wifi currentReachabilityStatus] != NotReachable) { // 有wifi
        xh(@"有wifi");
        
    } else if ([conn currentReachabilityStatus] != NotReachable) { // 没有使用wifi, 使用手机自带网络进行上网
        xh(@"使用手机自带网络进行上网");
        
    } else { // 没有网络
        
        xh(@"没有网络");
    }
}

@end
