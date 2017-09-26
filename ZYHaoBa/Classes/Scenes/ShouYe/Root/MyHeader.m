//
//  MyHeader.m
//  01.QQ好友列表
//
//  Created by apple on 13-9-16.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MyHeader.h"

@implementation MyHeader

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeaderHeight)];
        
        // 增加按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        xh(@"实例化标题行 %@", NSStringFromCGRect(self.bounds));
        
        [button setFrame:self.bounds];
        [button setBackgroundColor:[UIColor redColor]];
        // 设置渐变颜色
        [self setTintColor:[UIColor orangeColor]];
        // 设置按钮的图片
        UIImage *image = [UIImage imageNamed:@"disclosure.png"];
        [button setImage:image forState:UIControlStateNormal];
        
        // 设置按钮内容的显示位置
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        
        // 给按钮添加监听事件
        [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:button];
        
        self.button = button;
    }
    
    return self;
}

- (void)clickButton
{
    // 通知代理执行协议方法
    [self.delegate myHeaderDidSelectedHeader:self];
}

#pragma mark 展开折叠的setter方法
- (void)setIsOpen:(BOOL)isOpen
{
    _isOpen = isOpen;
    
    // 旋转按钮
    CGFloat angle = isOpen ? M_PI_2 : 0;
    
    [UIView animateWithDuration:0.5f animations:^{
        [self.button.imageView setTransform:CGAffineTransformMakeRotation(angle)];
    }];
}

@end
