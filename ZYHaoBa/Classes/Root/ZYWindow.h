//
//  ZYWindow.h
//  ZYHaoBa
//
//  Created by ylcf on 16/10/17.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CallTheService)(void);

@interface ZYWindow : UIWindow

//重要：所有图片都要是圆形的，程序里并没有自动处理成圆形

//  warning: frame的长宽必须相等
- (instancetype)initWithFrame:(CGRect)frame mainImageName:(NSString*)name bgcolor:(UIColor *)bgcolor;

// 长按雷达辐射效果
- (instancetype)initWithFrame:(CGRect)frame mainImageName:(NSString*)name bgcolor:(UIColor *)bgcolor animationColor:animationColor;

// 显示（默认）
- (void)showWindow;

// 隐藏
- (void)dissmissWindow;

@property (nonatomic,copy)CallTheService callService;

@end
