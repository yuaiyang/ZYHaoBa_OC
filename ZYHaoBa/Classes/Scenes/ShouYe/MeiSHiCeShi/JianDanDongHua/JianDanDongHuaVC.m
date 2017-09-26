//
//  JianDanDongHuaVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/20.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "JianDanDongHuaVC.h"

@interface JianDanDongHuaVC ()

{
    UIView *testView;
    BOOL isShow; // 在旋转中是是否旋转 其他为是否显示
}

@end

@implementation JianDanDongHuaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    testView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:testView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shang:(UIButton *)sender {
   
    //定义动画，进行对应的底部按钮数组视图切换动画处理操作
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseIn]];
    [animation setType:kCATransitionPush];
    
    //定义字符串，进行对应子动画类型的设定保存处理
    NSString *subType=nil;
    //当对应的视图为要显示状态时设定其动画方向为从右向左
    if(isShow) {
        isShow = NO;
        testView.hidden = YES;
        subType=kCATransitionFromBottom;
    }
    //当对应的视图为要隐藏状态时设定其动画方向为从左向右
    else {
        isShow = YES;
        testView.hidden = NO;
        subType=kCATransitionFromTop;
    }
    
    //为对应的按钮数组视图添加动画
    [animation setSubtype: subType];
    
    [testView.layer addAnimation:animation forKey:@"Transition"];
}

- (IBAction)xia:(UIButton *)sender {
    //定义动画，进行对应的底部按钮数组视图切换动画处理操作
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseIn]];
    [animation setType:kCATransitionPush];
    
    //定义字符串，进行对应子动画类型的设定保存处理
    NSString *subType=nil;
    //当对应的视图为要显示状态时设定其动画方向为从右向左
    if(isShow) {
        isShow = NO;
        testView.hidden = YES;
        subType=kCATransitionFromTop;
    }
    //当对应的视图为要隐藏状态时设定其动画方向为从左向右
    else {
        isShow = YES;
        testView.hidden = NO;
        subType=kCATransitionFromBottom;
    }
    
    //为对应的按钮数组视图添加动画
    [animation setSubtype: subType];
    
    [testView.layer addAnimation:animation forKey:@"Transition"];
}

- (IBAction)zuo:(UIButton *)sender {
    //定义动画，进行对应的底部按钮数组视图切换动画处理操作
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseIn]];
    [animation setType:kCATransitionPush];
    
    //定义字符串，进行对应子动画类型的设定保存处理
    NSString *subType=nil;
    //当对应的视图为要显示状态时设定其动画方向为从右向左
    if(isShow) {
        isShow = NO;
        testView.hidden = YES;
        subType=kCATransitionFromLeft;
    }
    //当对应的视图为要隐藏状态时设定其动画方向为从左向右
    else {
        isShow = YES;
        testView.hidden = NO;
        subType=kCATransitionFromRight;
    }
    
    //为对应的按钮数组视图添加动画
    [animation setSubtype: subType];
    
    [testView.layer addAnimation:animation forKey:@"Transition"];
}

- (IBAction)you:(UIButton *)sender {
    //定义动画，进行对应的底部按钮数组视图切换动画处理操作
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseIn]];
    [animation setType:kCATransitionPush];
    
    //定义字符串，进行对应子动画类型的设定保存处理
    NSString *subType=nil;
    //当对应的视图为要显示状态时设定其动画方向为从右向左
    if(isShow) {
        isShow = NO;
        testView.hidden = YES;
        subType=kCATransitionFromLeft;
    }
    //当对应的视图为要隐藏状态时设定其动画方向为从左向右
    else {
        isShow = YES;
        testView.hidden = NO;
        subType=kCATransitionFromLeft;
    }
    
    //为对应的按钮数组视图添加动画
    [animation setSubtype: subType];
    
    [testView.layer addAnimation:animation forKey:@"Transition"];
}

- (IBAction)xuanzhuan:(UIButton *)sender {
    
//    testView.transform = CGAffineTransformMakeRotation(M_PI_4);
    
//    [testView.layer setValue:@(M_PI_4) forKeyPath:@"transform.rotation.z"];
    
    // 旋转按钮
//    CGFloat angle = isShow ? M_PI_4 : 0;
    CGFloat angle = 0;
    if (isShow) {
        isShow = NO;
        angle = M_PI_4;
    } else {
        isShow = YES;
        angle = 0;
    }
    [UIView animateWithDuration:0.5f animations:^{
        [testView setTransform:CGAffineTransformMakeRotation(angle)];
    }];
}


- (IBAction)fanZhuan:(UIButton *)sender {
    [UIView transitionWithView:testView duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        // 在此设置视图反转之后显示的内容
        testView.backgroundColor = ZYRandomColor;
    } completion:^(BOOL finished) {
        xh(@"反转完成");
    }];
}

// 点击任何点都可以
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self.view];
    
    if ([touch view] == testView) {
        xh(@"点击myView");
    }
    [UIView animateWithDuration:1.0f animations:^{
        [testView setCenter:location];
    } completion:^(BOOL finished) {
        xh(@"%@", NSStringFromCGRect(testView.frame));
    }];
}

@end
