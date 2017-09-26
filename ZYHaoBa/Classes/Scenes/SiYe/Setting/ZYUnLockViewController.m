//
//  ZYUnLockViewController.m
//  ZYHaoBa
//
//  Created by ylcf on 16/8/12.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYUnLockViewController.h"
#import "MBGestureUnlockView.h"
//手势密码登录页面
#import "GesLoginViewController.h"

#import <LocalAuthentication/LAContext.h>
#import <LocalAuthentication/LAError.h>


#define kUnlockCount    5

@interface ZYUnLockViewController ()<GestureUnlockViewDelegate, UIAlertViewDelegate>
{
    MBGestureUnlockView * gestureUnlockView;
    int count;
    
    BOOL isInformJPush;     //当指纹解锁的时候，通知解锁后的跳页
}

@end

@implementation ZYUnLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手势解锁";
    
    //进行对应的手势解锁界面初始化操作
    gestureUnlockView = [[MBGestureUnlockView alloc] initWithFrame:CGRectMake(0, 0, 300, 300) backGroundImage:nil buttonNormalImage:nil buttonSelectImage:nil rowNum:3 colNum:3];
    gestureUnlockView.delegate = self;
    [self.view addSubview:gestureUnlockView];
    gestureUnlockView.center = CGPointMake(SCREEN_WIDTH/2, (SCREEN_HEIGHT-kNav_HEIGHT)/2);
    
    count = kUnlockCount;
    isInformJPush = NO;
    
    if (self.isNeedFingerUnlock) {
        [self.leftBtn setTitle:@"使用指纹解锁" forState:UIControlStateNormal];
        [self doClickUseFingerUnlock:self.leftBtn];
    }
    
    [__UserDefaults setBool:NO forKey:kISCanSaveTime];
}

- (void)doClickUseFingerUnlock:(UIButton *)sender {
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"请输入指纹";
    
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        myContext.localizedFallbackTitle = @"输入登录密码";
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL success, NSError *error) {
                                if (success) {
                                    [__UserDefaults setBool:YES forKey:kISCanSaveTime];
                                    [KEY_WINDOW.rootViewController dismissViewControllerAnimated:YES completion:^(void){}];
                                    
                                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                        //* 做跳页处理
                                        
                                    }];
                                    
                                    // User authenticated successfully, take appropriate action
                                } else {
                                    // User did not authenticate successfully, look at error and take appropriate action
                                    xh(@"error.code%ld", (long)error.code);
                                    NSString * msg;
                                    switch (error.code) {
                                        case LAErrorUserCancel:
                                            msg = @"取消";
                                            break;
                                        case LAErrorUserFallback: {
                                            msg = @"输入密码";
                                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                //用户选择输入密码，切换主线程处理
                                                //                                                [self showPassWordAlert];
                                                [self doClickRightAction:self.rightBtn];
                                            }];
                                        }
                                            break;
                                        default:
                                            msg = @"异常";
                                            break;
                                    }
                                    xh(@"点击-%@", msg);
                                }
                            }];
    }
}

#pragma mark-GestureActionDelegate
//定义函数，进行对应的手势解锁的对应代理的设置处理，进行对应的密码保存及相关的界面显示
-(void)didFinishTouchesInView:(MBGestureUnlockView *)gestureUnlockView withCode:(NSString *)currentCodeString {
    if (currentCodeString == nil || currentCodeString.length == 0) {
        xh(@"返回数据异常");
        return;
    }
    
    NSString * path = [ZYProTools readFileFromCacheWithFileName:GES_PWD];
    NSString * code = [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:path] encoding:NSUTF8StringEncoding];
    if ([currentCodeString isEqualToString:code]) {
        [__UserDefaults setBool:YES forKey:kISCanSaveTime];
        [KEY_WINDOW.rootViewController dismissViewControllerAnimated:YES completion:^(void){}];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //* 做跳页处理
            
        }];
        
        return;
    }
    else {
        count--;
        if (count <= 0) {
            //跳转至登录页面
            [ZYProTools showAlertViewWithMsg:[NSString stringWithFormat:@"您已经连续%d次输错手势密码,请重新登录", kUnlockCount] withDelegate:self withBtnText:@"登录"  WithTag:99];
            return;
        }
        self.msgLabel.text = [NSString stringWithFormat:@"输入错误,您还有%d次机会", count];
        self.msgLabel.textColor = ZYMAINCOLOER;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 99) {
        GesLoginViewController * view = [[GesLoginViewController alloc] init];
        view.isSynError = YES;      //相当于数据同步失败，有关闭按钮
        view.isNeedGes = YES;
        [self.navigationController pushViewController:view animated:YES];
    }
}

#pragma mark doAction
- (IBAction)doClickLeftAction:(id)sender {
    if (self.isNeedFingerUnlock) {
        [self doClickUseFingerUnlock:sender];
        return;
    }
    else {
        GesLoginViewController * view = [[GesLoginViewController alloc] init];
        view.isNeedGes = YES;
        [self.navigationController pushViewController:view animated:YES];
    }
}

- (IBAction)doClickRightAction:(id)sender {
    GesLoginViewController * view = [[GesLoginViewController alloc] init];
    view.isNeedGes = NO;
    view.isNeedExit = YES;
    [self.navigationController pushViewController:view animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
