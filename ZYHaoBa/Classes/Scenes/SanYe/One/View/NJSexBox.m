//
//  NJSexBox.m
//  32-键盘处理
//
//  Created by 李南江 on 14-2-9.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "NJSexBox.h"

@implementation NJSexBox

+(instancetype)sexBox
{
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"NJSexBox" owner:nil options:nil];
    return [array firstObject];
}

- (IBAction)sexChanged:(UIButton *)sender {
    if (_manBtn.enabled) {
//        选中男
        _manBtn.enabled = NO;
        _womanBtn.enabled = YES;
    }else
    {
//        选中女
        _manBtn.enabled = YES;
        _womanBtn.enabled = NO;
    }
}
@end
