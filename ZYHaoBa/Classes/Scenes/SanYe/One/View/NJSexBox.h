//
//  NJSexBox.h
//  32-键盘处理
//
//  Created by 李南江 on 14-2-9.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NJSexBox : UIView
//男
@property (weak, nonatomic) IBOutlet UIButton *manBtn;
//女
@property (weak, nonatomic) IBOutlet UIButton *womanBtn;
//点击性别按钮
- (IBAction)sexChanged:(UIButton *)sender;
//创建实例工厂方法
+ (instancetype)sexBox;
@end
