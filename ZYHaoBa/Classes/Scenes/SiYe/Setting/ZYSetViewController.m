//
//  ZYSetViewController.m
//  ZYHaoBa
//
//  Created by ylcf on 16/8/12.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYSetViewController.h"
#import "MBGestureUnlockView.h"


@interface ZYSetViewController ()<GestureUnlockViewDelegate, UIAlertViewDelegate>
{
    MBGestureUnlockView * gestureUnlockView;
}

@end

@implementation ZYSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绘制手势密码";
    
    //进行对应的手势解锁界面初始化操作
    gestureUnlockView=[[MBGestureUnlockView alloc] initWithFrame:CGRectMake(0, 0, 300.f, 300.f) backGroundImage:nil buttonNormalImage:nil buttonSelectImage:nil rowNum:3 colNum:3];
    gestureUnlockView.delegate = self;
    //    gestureUnlockView.isCanReceiveTouch = YES;//是否接受事件
    [self.view addSubview:gestureUnlockView];
    
    gestureUnlockView.center = CGPointMake(SCREEN_WIDTH/2, (SCREEN_HEIGHT-kNav_HEIGHT)/2);
    
    //数据处理
    self.isInputFirst = YES;
    
    if (self.isHiddenBackBtn) {
        UIButton * setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        setBtn.frame = CGRectMake(0, 0, 44, 44);
        // 调整 leftBarButtonItem 在 iOS7 下面的位置
        UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:setBtn];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        if (IS_IOS7) {
            negativeSpacer.width = -15;
        }
        else {
            negativeSpacer.width = -10;
        }
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, backNavigationItem];
    }
}

#pragma mark-GestureActionDelegate
//定义函数，进行对应的手势解锁的对应代理的设置处理，进行对应的密码保存及相关的界面显示
-(void)didFinishTouchesInView:(MBGestureUnlockView *)gestureUnlockView withCode:(NSString *)currentCodeString
{
    if (currentCodeString == nil || currentCodeString.length == 0) {
        xh(@"返回数据异常");
        return;
    }
    
    //录入
    if (self.isInputFirst) {
        //将第一次录入的数据进行存储
        [[NSUserDefaults standardUserDefaults] setObject:currentCodeString forKey:@"key"];
        self.msgLabel.text = @"再次输入手势密码";
        self.againBtn.hidden = NO;
        self.isInputFirst = NO;
        return;
    }
    else {
        NSString * code = [[NSUserDefaults standardUserDefaults] objectForKey:@"key"];
        if ([code isEqualToString:currentCodeString]) {
            //两次设置一致，页面转换
            if (self.isHiddenBackBtn) {
                NSString * code = [[NSUserDefaults standardUserDefaults] objectForKey:@"key"];
                [ZYProTools writeFileToCache:code dataType:@"NSString" FileName:GES_PWD];
                [ZYProTools writeFileToCache:@"1" dataType:@"NSString" FileName:START_GES];
                
                [self.delegate setGesture];
                showAlert(@"设置成功");
                [KEY_WINDOW.rootViewController dismissViewControllerAnimated:YES completion:nil];
            }
            else {
                [ZYProTools showAlertViewWithMsg:@"设置成功" withDelegate:self withBtnText:@"确定"  WithTag:99];
            }
            return;
        }
        else {
            //不一致 提示
            showAlert(@"前后手势不一致，请重新输入");
            return;
        }
    }
}

- (IBAction)doDelInput:(id)sender {
    self.isInputFirst = YES;
    self.msgLabel.text = @"请输入手势密码";
    self.againBtn.hidden = YES;
}

#pragma mark UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //数据存储
    NSString * code = [[NSUserDefaults standardUserDefaults] objectForKey:@"key"];
    [ZYProTools writeFileToCache:code dataType:@"NSString" FileName:GES_PWD];
    [ZYProTools writeFileToCache:@"1" dataType:@"NSString" FileName:START_GES];
    
    [self.delegate setGesture];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
