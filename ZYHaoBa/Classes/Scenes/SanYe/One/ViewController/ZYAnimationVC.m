//
//  ZYAnimationVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/11.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYAnimationVC.h"

@interface ZYAnimationVC ()

{
    UIView *animationView;
}

@end

@implementation ZYAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    animationView = [[UIView alloc] initWithFrame:CGRectMake(150, 400, 50, 50)];
    animationView.backgroundColor = ZYRandomColor;
    [self.view addSubview:animationView];
}

#pragma mark 点击从上往下动画视图
- (IBAction)didClickTopBtn:(UIButton *)sender {
    [animationView.layer setValue:@(-100) forKeyPath:@"transform.translation.y"];
}

#pragma mark 点击从下往上动画视图
- (IBAction)didClickBoyyomBtn:(UIButton *)sender {
    [animationView.layer setValue:@(100) forKeyPath:@"transform.translation.y"];
}

#pragma mark 点击从左往右动画视图
- (IBAction)didClickLeftBtn:(UIButton *)sender {
    [animationView.layer setValue:@(100) forKeyPath:@"transform.translation.x"];
}

#pragma mark 点击从右往左动画视图
- (IBAction)didClickRightBtn:(UIButton *)sender {
    [animationView.layer setValue:@(-100) forKeyPath:@"transform.translation.x"];
}

#pragma mark 点击其他动画视图
- (IBAction)didClickSpecialBtn:(UIButton *)sender {
    //定义动画，进行对应的底部按钮数组视图切换动画处理操作
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.35f];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseIn]];
    [animation setType:kCATransitionPush];
    
    //定义字符串，进行对应子动画类型的设定保存处理
    NSString *subType=nil;
    // 设置4(不包括4，包括0)范围内的随机数
    NSInteger i = (NSInteger)arc4random() % 4;
    switch (i) {
        case 0:
            subType=kCATransitionFromTop;
            break;
        case 1:
            subType=kCATransitionFromBottom;
            break;
        case 2:
            subType=kCATransitionFromLeft;
            break;
        case 3:
            subType=kCATransitionFromRight;
            break;
        default:
            break;
    }
    
    //为对应的按钮数组视图添加动画
    [animation setSubtype: subType];
    
    [animationView.layer addAnimation:animation forKey:@"Transition"];
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
