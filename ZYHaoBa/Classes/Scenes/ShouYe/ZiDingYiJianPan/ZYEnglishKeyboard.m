//
//  ZYEnglishKeyboard.m
//  更改键盘按钮
//
//  Created by ylcf on 16/12/13.
//  Copyright © 2016年 sgx. All rights reserved.
//

#import "ZYEnglishKeyboard.h"

@interface ZYEnglishKeyboard()
/** 键盘上的按钮 */
@property (nonatomic, strong) NSArray *englishs;
@end

@implementation ZYEnglishKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createEnglishBtn];
    }
    return self;
}

- (void)createEnglishBtn {
    CGFloat w = [UIScreen mainScreen].bounds.size.width/7;
    CGFloat h = 256.0/4;
    for (int i = 0; i < self.englishs.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.x = (i % 7) * w;
        btn.y = (i / 7) *h;
        btn.width = w;
        btn.height = h;
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.borderColor = [UIColor redColor].CGColor;
        btn.layer.borderWidth = 1.0;
        [btn setTitle:_englishs[i] forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:btn];
    }
}

-(void)didClickBtn:(UIButton *)btn {
    // 在这里发出通知告诉控制器我点击了谁
    [[NSNotificationCenter defaultCenter] postNotificationName:ZYNumberDidSelectedNotification object:nil userInfo:@{ZYSelectedNumber:btn.titleLabel.text}];
}

-(NSArray *)englishs {
    if (_englishs == nil) {
        _englishs = @[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",@"z",@"x",@"c",@"v",@"b",@"n",@"m",@"123",@"确认"];
    }
    return _englishs;
}

@end
