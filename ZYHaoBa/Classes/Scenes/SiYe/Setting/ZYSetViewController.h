//
//  ZYSetViewController.h
//  ZYHaoBa
//
//  Created by ylcf on 16/8/12.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYViewController.h"

@protocol SetPGMDelegate <NSObject>

- (void)setGesture;

@end


@interface ZYSetViewController : ZYViewController

//返回按钮
@property (nonatomic, assign) BOOL isHiddenBackBtn;

//录入的时候是否为第一次
@property (nonatomic, assign) BOOL isInputFirst;

//一次、二次密码输入提示语
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;
////密码View
//@property (weak, nonatomic) IBOutlet UIView *GestureBgView;
//底部按钮
@property (weak, nonatomic) IBOutlet UIButton *againBtn;

@property (nonatomic, assign) id <SetPGMDelegate> delegate;

@end
