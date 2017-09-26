//
//  ZYKeyboard.m
//  更改键盘按钮
//
//  Created by ylcf on 16/12/13.
//  Copyright © 2016年 sgx. All rights reserved.
//

#import "ZYKeyboard.h"
#import "ZYNumberKeyboard.h"
#import "ZYEnglishKeyboard.h"
#import "ZYDeleteBtnToolBar.h"

@interface ZYKeyboard()
@property (nonatomic, weak)ZYEnglishKeyboard *englishKeyboard;
@property (nonatomic, weak)ZYNumberKeyboard *numKeyboard;
@end

@implementation ZYKeyboard
+(instancetype)keyboard {
    return [[self alloc] init];
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat screenw = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenh = [UIScreen mainScreen].bounds.size.height;
        CGFloat keyboardh = 256;
        CGFloat toolBarh = 40;
        self.frame = CGRectMake(0, screenh - keyboardh, screenw, keyboardh + toolBarh);
        CGRect toolBarFrame = CGRectMake(0, 0, screenw, toolBarh);
        CGRect keyboardFrame = CGRectMake(0, toolBarh, screenw, keyboardh);
        // 添加含有删除按钮的toolBar
        ZYDeleteBtnToolBar *toolBar = [[ZYDeleteBtnToolBar alloc] initWithFrame:toolBarFrame];
        [self addSubview:toolBar];
        
        // 添加数字键盘
        ZYNumberKeyboard *numKeyboard = [[ZYNumberKeyboard alloc] initWithFrame:keyboardFrame];
        [self addSubview:numKeyboard];
        self.numKeyboard = numKeyboard;
        
        // 添加英文键盘
        ZYEnglishKeyboard *englishKeyboard = [[ZYEnglishKeyboard alloc] initWithFrame:keyboardFrame];
        [self addSubview:englishKeyboard];
        self.englishKeyboard = englishKeyboard;
        self.englishKeyboard.hidden = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeKeyboardType:) name:ZYNumberDidSelectedNotification object:nil];
    }
    return self;
}

#pragma mark - 更改键盘
- (void)changeKeyboardType:(NSNotification *)info {
    if ([info.userInfo[ZYSelectedNumber] isEqualToString:@"123"]) {
        self.englishKeyboard.hidden = YES;
        self.numKeyboard.hidden = NO;
    }
    if ([info.userInfo[ZYSelectedNumber] isEqualToString:@"abc"]) {
        self.numKeyboard.hidden = YES;
        self.englishKeyboard.hidden = NO;
    }
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
