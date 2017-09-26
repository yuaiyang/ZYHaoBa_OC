//
//  NJKeyboardTool.m
//  32-键盘处理
//
//  Created by 李南江 on 14-2-9.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "NJKeyboardTool.h"

@implementation NJKeyboardTool

+(instancetype)keyboardTool
{
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"NJKeyboardTool" owner:nil options:nil];
    return [array firstObject];
}

- (IBAction)previousClick:(UIBarButtonItem *)sender {
    
    if ([_delegate respondsToSelector:@selector(keyboardTool:itemClick:)]) {
        [_delegate keyboardTool:self itemClick:NJKeyboardToolItemTypePrevious];
    }
}

- (IBAction)nextClick:(UIBarButtonItem *)sender {
    
    if ([_delegate respondsToSelector:@selector(keyboardTool:itemClick:)]) {
        [_delegate keyboardTool:self itemClick:NJKeyboardToolItemTypeNext];
    }
}

- (IBAction)finishClick:(UIBarButtonItem *)sender {
    
    if ([_delegate respondsToSelector:@selector(keyboardTool:itemClick:)]) {
        [_delegate keyboardTool:self itemClick:NJKeyboardToolItemTypeFinish];
    }
}
@end
