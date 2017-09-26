//
//  ZYNumberKeyboard.m
//  更改键盘按钮
//
//  Created by ylcf on 16/12/13.
//  Copyright © 2016年 sgx. All rights reserved.
//

#import "ZYNumberKeyboard.h"

@interface ZYNumberKeyboard()
/** 键盘上的按钮 */
@property (nonatomic, strong) NSArray *numbers;
/** 键盘上的按钮 */
@property (nonatomic, strong) NSMutableArray *mutableNumbers;
@end

@implementation ZYNumberKeyboard

-(NSArray *)numbers {
    if (_numbers == nil) {
        _numbers = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"abc",@"0",@"确认"];
    }
    return _numbers;
}

-(NSMutableArray *)mutableNumbers {
    if (_mutableNumbers == nil) {
        _mutableNumbers = [NSMutableArray array];
        for (int i = 0 ; i < 10; i++) {
            int j = arc4random_uniform(10);
            
            NSNumber *number = [[NSNumber alloc] initWithInt:j];
            if ([_mutableNumbers containsObject:number]) {
                i--;
                continue;
            }
            [_mutableNumbers addObject:number];
        }
    }
    return _mutableNumbers;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createNumberBtn];
    }
    return self;
}

- (void)createNumberBtn {
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width/3;
    CGFloat h = 256.0/4;
    for (int i = 0; i < self.numbers.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.x = (i % 3) * w;
        btn.y = (i / 3) *h;
        btn.width = w;
        btn.height = h;
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.borderColor = [UIColor redColor].CGColor;
        btn.layer.borderWidth = 1.0;
        [btn setTitle:_numbers[i] forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:btn];
    }
}

-(void)didClickBtn:(UIButton *)btn {
    // 在这里发出通知告诉控制器我点击了谁
    [[NSNotificationCenter defaultCenter] postNotificationName:ZYNumberDidSelectedNotification object:nil userInfo:@{ZYSelectedNumber:btn.titleLabel.text}];
}

@end
