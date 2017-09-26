//
//  UIBarButtonItem+Extension.m
//  ZYHaoBa
//
//  Created by ylcf on 16/8/22.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    
    // 设置按钮的尺寸为背景图片的尺寸
    button.size = button.currentBackgroundImage.size;
    
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)barButtonItemWithTitleName:(NSString *)titleName target:(id)target action:(SEL)action TintColor:(UIColor *)tintColor font:(float)font {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:titleName style:(UIBarButtonItemStylePlain) target:target action:action];
    [item setTintColor:tintColor];
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName,nil] forState:UIControlStateNormal];
    return item;
}

+ (NSArray *)barButtonItemWithframe:(CGRect)frame bankgroundImageName:(NSString *)imgName target:(id)target action:(SEL)action offset:(float)offset {
    UIButton * mineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mineBtn.frame = frame;
    [mineBtn setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [mineBtn setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateHighlighted];
    [mineBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 调整 leftBarButtonItem 的位置
    UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:mineBtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = offset;
    return @[negativeSpacer, backNavigationItem];
}

@end
