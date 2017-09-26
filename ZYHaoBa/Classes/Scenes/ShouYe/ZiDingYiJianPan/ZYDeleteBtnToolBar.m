//
//  ZYDeleteBtnToolBar.m
//  更改键盘按钮
//
//  Created by ylcf on 16/12/13.
//  Copyright © 2016年 sgx. All rights reserved.
//

#import "ZYDeleteBtnToolBar.h"

@implementation ZYDeleteBtnToolBar

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    UILabel *label = [[UILabel alloc] init];
    label.width = 200;
    label.height = self.height;
    label.centerX = self.centerX;
    label.centerY = self.centerY;
    label.text = @"一路财富安全键盘";
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 50, 0, 50, self.height)];
    [btn setTitle:@"删除" forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(didClickDeleteBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:btn];
}

- (void)didClickDeleteBtn {
    // 在这里发出通知告诉控制器我点击了谁
    [[NSNotificationCenter defaultCenter] postNotificationName:ZYToolBarDidSelectedDeleteNotification object:nil userInfo:nil];
}

@end
