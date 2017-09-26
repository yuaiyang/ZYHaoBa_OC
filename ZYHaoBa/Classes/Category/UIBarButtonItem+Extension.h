//
//  UIBarButtonItem+Extension.h
//  ZYHaoBa
//
//  Created by ylcf on 16/8/22.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
#pragma mark - 传入图片设置导航栏按钮
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;
#pragma mark - 传入文字设置导航栏按钮
+ (UIBarButtonItem *)barButtonItemWithTitleName:(NSString *)titleName target:(id)target action:(SEL)action TintColor:(UIColor *)tintColor font:(float)font;
#pragma mark - 传入图片位置 图片名字 设置导航栏按钮 返回数组
+ (NSArray *)barButtonItemWithframe:(CGRect)frame bankgroundImageName:(NSString *)imgName target:(id)target action:(SEL)action offset:(float)offset;
@end
