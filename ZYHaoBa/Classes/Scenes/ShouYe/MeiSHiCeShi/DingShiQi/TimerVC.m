//
//  TimerVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/20.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "TimerVC.h"

@interface TimerVC ()
{
    NSTimer * timer;    //倒计时
    int totalTime;
}
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

- (IBAction)didClickTimerBtn:(UIButton *)sender;
@end

@implementation TimerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"定时器";
    // 设置定时器时间
    totalTime = 30;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)didClickTimerBtn:(UIButton *)sender {
    //如果正在倒计时，则返回不做处理
    if (timer && [timer isValid]) {
        return;
    }
    //不重复，只调用一次。timer运行一次就会自动停止运行
    timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(ChangeViewColor) userInfo:nil repeats:NO];
    
    //每1秒运行一次ChangeViewFrame方法。
    timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(ChangeViewFrame) userInfo:nil repeats:YES];
}

#pragma mark ChangeViewColor
- (void)ChangeViewColor {
    [self.codeBtn setImage:[UIImage imageNamed:@"main_badge.png"] forState:(UIControlStateNormal)];
    // 如果要移除 那么最好是取消定时器 否则ChangeViewFrame会继续调用
//    [self.codeBtn removeFromSuperview];
//    [timer invalidate];
}

#pragma mark ChangeViewFrame
- (void)ChangeViewFrame {
    totalTime--;
    if (totalTime == 0) {
        if ([timer isValid]) {
            [timer invalidate];
        }
        self.codeBtn.enabled = YES;
        totalTime = 30;
    }
    else {
        [self.codeBtn setTitle:[NSString stringWithFormat:@"剩余时间：%d", totalTime] forState:UIControlStateDisabled];
        self.codeBtn.enabled = NO;
    }
}

#pragma mark 页面消失处理时间
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    判断定时器在运行时
    if ([timer isValid]) {
        // 取消定时器
        [timer invalidate];
        totalTime = 30;
        self.codeBtn.enabled = YES;
    }
}
@end
