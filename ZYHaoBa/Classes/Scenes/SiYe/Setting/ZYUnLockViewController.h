//
//  ZYUnLockViewController.h
//  ZYHaoBa
//
//  Created by ylcf on 16/8/12.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYViewController.h"

@interface ZYUnLockViewController : ZYViewController


@property (nonatomic, assign) BOOL isNeedFingerUnlock;       //需要指纹解锁

//一次、二次密码输入提示语
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;

//按钮
//@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
//@property (weak, nonatomic) IBOutlet UIButton *otherBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@end
