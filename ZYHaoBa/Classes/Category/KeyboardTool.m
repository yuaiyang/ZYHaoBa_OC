//
//  KeyboardTool.m
//  ZYHaoBa
//
//  Created by ylcf on 16/9/16.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "KeyboardTool.h"

@implementation KeyboardTool

#pragma mark 实例化助手视图
+ (id)KeyboardTool
{
    // 从XIB中加载一组平行的视图数组，然后从中找到定义好的键盘助手视图
    // 在本示例中，只有一个视图
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"KeyboardTool" owner:nil options:nil];
    
    return array.lastObject;
}

#pragma mark 按钮操作
- (IBAction)clickPrev:(UIBarButtonItem *)sender
{
    [_toolDelegate KeyboardTool:self buttonType:kKeyboardToolButtonPrev];
}

- (IBAction)clickNext:(id)sender
{
    [_toolDelegate KeyboardTool:self buttonType:kKeyboardToolButtonNext];
}

- (IBAction)clickDone:(UIBarButtonItem *)sender
{
    [_toolDelegate KeyboardTool:self buttonType:kKeyboardToolButtonDone];
}


@end
