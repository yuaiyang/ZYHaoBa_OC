//
//  BoDaDianHuaVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/20.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "BoDaDianHuaVC.h"

@interface BoDaDianHuaVC ()
{
    UIApplication *app;
}
- (IBAction)CallPhoneBtn:(UIButton *)sender;

- (IBAction)sendMsgBtn:(UIButton *)sender;

- (IBAction)sendEmailBtn:(UIButton *)sender;

@end

@implementation BoDaDianHuaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setApp];
    // 设置图标右上角显示的数字
    [self setRightCornerNUmber];
}

- (void)setApp {
    // 一般来讲，所有用shared开头创建的对象，都是单例
    app = [UIApplication sharedApplication];
//    UIWindow *window = app.keyWindow;
//    
//    for (UIView *view in window.subviews) {
//        xh(@"%@ %@", view, self.view);
//    }
    
    // 显示联网状态的提示，一般有网络请求时，会自动显示
    [app setNetworkActivityIndicatorVisible:YES];
}

- (void)setRightCornerNUmber {
    // 设置图标右上角显示的数字 iOS 8.0以后需要有通知 看用户是否允许
    // 提醒：在设置数字时，要谨慎，对于强迫症患者
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    
    [app registerUserNotificationSettings:settings];
    
    // 应用程序右上角数字
    app.applicationIconBadgeNumber = 79;
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    // 联网状态的提示，一般请求完毕后需要取消 在这里页面消失取消
    [app setNetworkActivityIndicatorVisible:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)CallPhoneBtn:(UIButton *)sender {
    // 打开一个URL
    // 在iOS中，很多东西都可以通过URL来访问，例如：电话、短信、电子邮件等
    //    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    // 电话会直接呼出
        NSURL *url = [NSURL URLWithString:@"tel://15034322235"];
    [app openURL:url];
}

- (IBAction)sendMsgBtn:(UIButton *)sender {
    // 会跳出短信发送界面，等待用户编辑并发送短信
    NSURL *url = [NSURL URLWithString:@"sms://15034322235"];
    [app openURL:url];
}

- (IBAction)sendEmailBtn:(UIButton *)sender {
    showAlert(@"发送邮件比较麻烦，有需要去网上就可以找到方法");
}
@end
